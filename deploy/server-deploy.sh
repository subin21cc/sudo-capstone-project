#!/usr/bin/env bash
# 서버에서 실행: private-deploy 최신 커밋으로 백엔드(DB·앱)를 다시 띄우고 헬스 체크한다.
#
#   bash ~/oncare/deploy/server-deploy.sh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ ! -f backend/.env ]]; then
  echo "[deploy] backend/.env 가 없습니다 — deploy/env.private.example 을 복사해 채우세요." >&2
  exit 1
fi

git fetch origin private-deploy
git checkout private-deploy
git merge --ff-only origin/private-deploy
export GIT_SHA
GIT_SHA="$(git rev-parse HEAD)"

COMPOSE=(docker compose -p oncare
  -f backend/docker-compose.yml -f deploy/docker-compose.private.yml
  --env-file backend/.env)

"${COMPOSE[@]}" up -d --build

echo "[deploy] waiting for /v1/healthz ($GIT_SHA)"
for _ in $(seq 1 60); do
  # FORCE_HTTPS 라 평문 요청은 307 이 된다 — nginx 처럼 https 로 왔다고 알린다.
  if body="$(curl -fsS -H "X-Forwarded-Proto: https" http://127.0.0.1:8000/v1/healthz)" \
      && grep -q "\"commit_sha\":\"$GIT_SHA\"" <<<"$body"; then
    echo "$body"
    echo
    echo "[deploy] ok"
    exit 0
  fi
  sleep 2
done
echo "[deploy] healthz 실패 — 최근 로그:" >&2
"${COMPOSE[@]}" logs --tail 80 app >&2
exit 1
