# oncare-flutter

[Oncare Prototype (React/TS)](https://github.com/subin21cc/Oncareprototype) 를 Flutter로 재구성하는 프로젝트입니다.
**Android / iOS / Web** 3개 타깃을 단일 코드베이스로 빌드하며, 웹은 GitHub Pages에 CI 배포됩니다.

> 현재 상태: **Stage 1 — Bootstrap 완료** → Stage 2 (Core Infrastructure) 진입 예정

## 문서

- [docs/PLAN.md](./docs/PLAN.md) — 전체 로드맵 (Stage × Phase), 기술 스택, [결정 이력](./docs/PLAN.md#9-결정-이력-decision-log)
- [docs/STRUCTURE.md](./docs/STRUCTURE.md) — Flutter 디렉토리 구조 및 아키텍처 의존성 규칙
- [docs/DESIGN_TOKENS.md](./docs/DESIGN_TOKENS.md) — 디자인 토큰 초안 (Figma 접근 후 보강)
- [docs/CONTRIBUTING_NOTES.md](./docs/CONTRIBUTING_NOTES.md) — 커밋 컨벤션, AI co-author trailer 미사용 정책, Phase/Stage 커밋·푸시 케이던스

## 빌드 / 실행

```bash
# 의존성
flutter pub get

# Web (개발)
flutter run -d chrome \
  --dart-define=ENV=dev \
  --dart-define=API_BASE_URL=https://dev.api.oncare.example.com

# Web (배포 빌드, GitHub Pages용)
flutter build web --release \
  --base-href "/oncare-flutter/" \
  --dart-define=ENV=prod \
  --dart-define=API_BASE_URL=https://api.oncare.example.com

# Android
flutter run -d <android-device>  # debug
flutter build apk --release      # 또는 build appbundle

# iOS
flutter run -d <ios-device>      # debug
flutter build ios --release      # Xcode에서 archive
```

## CI / CD

`.github/workflows/`:

- **`ci.yml`** — `push`(main) / `pull_request`에서 `dart format` + `flutter analyze` + `flutter test` 실행
- **`deploy-web.yml`** — `push`(main) 시 `flutter build web` 후 GitHub Pages에 자동 배포 → `https://barmi.github.io/oncare-flutter/`

### 최초 1회 수동 설정 (push 전에)

GitHub Pages가 활성화되어 있어야 deploy 워크플로우가 작동합니다.

1. 레포 → **Settings → Pages**
2. **Source**: `GitHub Actions` 로 변경
3. (선택) **Settings → Secrets and variables → Actions → Variables** 에 `API_BASE_URL` 등록 — 미설정 시 dev 기본값 사용

## Stage 진행 현황

- [x] **Stage 0 — Discovery & Decision** (PLAN, STRUCTURE, DESIGN_TOKENS, 결정 Q1–Q12)
- [x] **Stage 1 — Bootstrap** (flutter create, deps, lint, AppConfig, CI/CD)
- [ ] Stage 2 — Core Infrastructure (router, theme, storage, API client, l10n)
- [ ] Stage 3 — Design System
- [ ] Stage 4 — Features (Dashboard / Diet / Exercise / MyHealth / AICoach / Notification / Place / Auth)
- [ ] Stage 5 — Integration & Polish
- [ ] Stage 6 — Quality
- [ ] Stage 7 — Release
