#!/usr/bin/env bash
# 회원 앱·트레이너 웹을 운영(실서버) 모드로 빌드해 서버의 정적 폴더에 올린다.
# 로컬(Mac)에서 실행한다. Flutter 버전은 upstream CI 와 같은 3.44.9.
#
#   bash deploy/frontend.sh               # 빌드 + 업로드
#   bash deploy/frontend.sh --build-only  # 빌드만 (deploy/out/public)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT/deploy/.env.frontend"
if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
fi
PUBLIC_URL="${PUBLIC_URL:-https://flc.tailf0d4a.ts.net}"
API_BASE_URL="${API_BASE_URL:-$PUBLIC_URL/v1}"
KAKAO_JS_KEY="${KAKAO_JS_KEY:-}"
SERVER="${SERVER:-yoshi@flc.tailf0d4a.ts.net}"
WEB_ROOT="${WEB_ROOT:-/srv/oncare/www}"
RELEASE_SHA="$(git -C "$ROOT" rev-parse HEAD)"
OUT="$ROOT/deploy/out/public"

if [[ -n "$(git -C "$ROOT" status --porcelain -- frontend shared)" ]]; then
  echo "[frontend] 경고: frontend/·shared/ 에 커밋되지 않은 변경이 있습니다 — 빌드에 함께 들어갑니다." >&2
fi
if [[ -z "$KAKAO_JS_KEY" ]]; then
  echo "[frontend] 경고: KAKAO_JS_KEY 가 비어 있어 지도가 표시되지 않습니다(deploy/.env.frontend)." >&2
fi

build_app() {
  local dir="$1" base="$2"
  echo "[frontend] build $dir → /$base/"
  (
    cd "$ROOT/frontend/$dir"
    flutter pub get
    bash tool/fetch_drift_wasm.sh
    flutter build web --release --base-href "/$base/" \
      --dart-define=RELEASE_SHA="$RELEASE_SHA" \
      --dart-define=KAKAO_JS_KEY="$KAKAO_JS_KEY" \
      --dart-define=USE_MOCK_API=false \
      --dart-define=API_BASE_URL="$API_BASE_URL" \
      --dart-define=ENV=prod
  )
}

build_app flutter frontend
build_app flutter_trainer trainer

rm -rf "$OUT"
mkdir -p "$OUT/frontend" "$OUT/trainer" "$OUT/legal"
cp -R "$ROOT/frontend/flutter/build/web/." "$OUT/frontend/"
cp -R "$ROOT/frontend/flutter_trainer/build/web/." "$OUT/trainer/"
cp "$ROOT"/legal/*.html "$OUT/legal/"
find "$OUT" -name '*.js.symbols' -delete
echo "$RELEASE_SHA" > "$OUT/version.txt"
cp "$OUT/version.txt" "$OUT/frontend/version.txt"
cp "$OUT/version.txt" "$OUT/trainer/version.txt"
echo "[frontend] built $RELEASE_SHA → $OUT"

if [[ "${1:-}" == "--build-only" ]]; then
  exit 0
fi

echo "[frontend] upload → $SERVER:$WEB_ROOT"
rsync -az --delete "$OUT/" "$SERVER:$WEB_ROOT/"
echo "[frontend] done: $PUBLIC_URL/frontend/  ·  $PUBLIC_URL/trainer/"
