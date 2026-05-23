# oncare-flutter

[Oncare Prototype (React/TS)](https://github.com/subin21cc/Oncareprototype) 를 Flutter로 재구성하는 프로젝트입니다.
**Android / iOS / Web** 3개 타깃을 단일 코드베이스로 빌드하며, 웹은 GitHub Pages에 CI 배포할 예정입니다.

> 현재 상태: **Stage 0 — Discovery & Decision 완료** → Stage 1 Bootstrap 진입 예정

## 문서

- [docs/PLAN.md](./docs/PLAN.md) — 전체 로드맵 (Stage × Phase), 기술 스택, [결정 이력](./docs/PLAN.md#9-결정-이력-decision-log)
- [docs/STRUCTURE.md](./docs/STRUCTURE.md) — Flutter 디렉토리 구조 및 아키텍처 의존성 규칙
- [docs/DESIGN_TOKENS.md](./docs/DESIGN_TOKENS.md) — 디자인 토큰 초안 (Figma 접근 후 보강)
- [docs/CONTRIBUTING_NOTES.md](./docs/CONTRIBUTING_NOTES.md) — 커밋 컨벤션, AI co-author trailer 미사용 정책, Phase/Stage 커밋·푸시 케이던스

## 빌드 타깃

- **Android** — `flutter build apk` / `aab`
- **iOS** — `flutter build ios` (수동 릴리즈)
- **Web** — `flutter build web --base-href "/oncare-flutter/"` → GitHub Pages 자동 배포 (`https://barmi.github.io/oncare-flutter/`)

## 다음 단계 (Stage 1)

1. `flutter create --org com.barmi --project-name oncare --platforms=android,ios,web .`
2. `lib/` 골격 생성 ([STRUCTURE.md](./docs/STRUCTURE.md))
3. `pubspec.yaml` 의존성 추가 + `analysis_options.yaml`
4. `.github/workflows/ci.yml`, `.github/workflows/deploy-web.yml`
