# 기여 / 커밋 규약

> 본 프로젝트는 **AI 도구의 co-author trailer를 사용하지 않습니다**. 모든 커밋은 사용자 본인 계정만 author/committer로 기록됩니다.

---

## 1. AI co-author trailer 미사용 정책

다른 일부 워크플로우에서는 다음과 같은 trailer가 자동으로 추가되곤 합니다.

```
Co-Authored-By: Claude <noreply@anthropic.com>
```

본 프로젝트에서는 **이 줄을 어떤 커밋에도 포함하지 않습니다**. 사유:

- 사용자가 직접 git push 하고, GitHub의 contributors 목록에 본인만 노출되기를 원함.
- 외부 협업자가 봤을 때 코드 author가 명확해야 함.

### 1.1 운영 방법

| 시나리오 | 조치 |
| --- | --- |
| 사용자가 직접 손으로 커밋 | 자연스럽게 trailer가 없으므로 별도 조치 불필요. |
| Claude Code 등 AI 에이전트가 커밋 메시지 초안을 작성 | 메시지에서 `Co-Authored-By:` 줄을 **절대 추가하지 않음**. 본 레포의 메모리(`feedback_no_coauthor`)에 명시됨. |
| 실수로 trailer가 포함된 커밋이 푸시되기 전 발견 | `git commit --amend` 로 메시지 수정. |
| 푸시 후 발견 | `git rebase -i <base>` 로 메시지 수정 → force push (개인 브랜치에 한함). main에 이미 머지된 경우 새 커밋으로 정정 메시지 작성 후 진행. |

> ⚠️ force push는 개인/피처 브랜치에서만. main에는 절대 force push 금지.

### 1.2 (선택) commit-msg hook으로 자동 차단

원치 않는 trailer 유입을 막고 싶다면 `.githooks/commit-msg` 를 설정하세요.

```bash
#!/usr/bin/env bash
set -e
if grep -qiE '^Co-Authored-By:\s*(Claude|Anthropic|Copilot|Cursor|Codex)' "$1"; then
  echo "ERR: AI co-author trailer is not allowed in this repo." >&2
  echo "    Remove the 'Co-Authored-By: ...' line before committing." >&2
  exit 1
fi
```

활성화:

```bash
chmod +x .githooks/commit-msg
git config core.hooksPath .githooks
```

이 훅은 **로컬 설정**이라 레포에 들어와도 자동 활성화되지 않습니다. 팀원이 사용하려면 위 `git config core.hooksPath` 한 줄을 안내해야 합니다.

---

## 2. 커밋 메시지 컨벤션

[Conventional Commits](https://www.conventionalcommits.org/) 를 따릅니다.

```
<type>(<scope>): <subject>

<body>

<footer>
```

- `type`: `feat | fix | docs | style | refactor | perf | test | build | ci | chore | revert`
- `scope`(선택): 영향 받는 영역. 예: `dashboard`, `diet`, `core/network`, `ci`
- `subject`: 명령형, 끝에 마침표 없음, 한국어/영어 모두 허용
- `body`: 왜 변경했는지 (무엇이 변경됐는지는 diff가 말해줌)
- `footer`: `BREAKING CHANGE:` 또는 이슈 참조 (`Closes #12`)

### 예시

```
feat(diet): add daily nutrition summary card

영양소 일일 합계를 대시보드와 식단 화면에서 공통 사용할 수 있도록 카드 위젯을 추가.
이후 Exercise 화면에서도 동일 패턴 재사용 예정.
```

```
ci: deploy web build to GitHub Pages on main push

actions/deploy-pages v4 사용. base-href는 /oncare-flutter/.
```

---

## 3. 커밋·푸시 케이던스

본 프로젝트는 [PLAN.md](./PLAN.md) 의 Stage × Phase 구조에 맞춰 다음 케이던스로 git 작업을 합니다.

| 시점 | 명령 |
| --- | --- |
| 각 **Phase** 종료 시 | `git commit` — push 안 함 |
| 각 **Stage** 종료 시 | `git commit && git push origin main` |

이 규칙은 사용자가 직접 작업할 때뿐 아니라 AI 에이전트(예: Claude Code)가 작업할 때도 동일하게 적용됩니다.

> ⚠️ main 브랜치에 force push 금지. push가 실패하면 원인부터 확인하고, 대부분의 경우 `git pull --rebase` 로 해결합니다.

---

## 4. 브랜치 전략 (제안)

| 브랜치 | 용도 |
| --- | --- |
| `main` | 항상 배포 가능한 상태. 직접 push 또는 PR 머지로 갱신. |
| `feat/<name>` | 신규 기능 |
| `fix/<name>` | 버그 수정 |
| `chore/<name>` | 의존성/빌드 등 |

> MVP 기간에는 main 직접 push도 허용하나, 외부 협업이 시작되면 PR 기반으로 전환.

---

## 5. PR 체크리스트 (외부 협업 시점부터 적용)

- [ ] `flutter analyze` 통과
- [ ] `flutter test` 통과
- [ ] 새로 추가/변경한 위젯에 위젯 테스트 또는 골든 테스트
- [ ] 다국어 텍스트는 ARB 등록 후 사용
- [ ] 디자인 토큰 외 색/간격 하드코딩 없음
- [ ] PR 본문에 스크린샷/녹화(UI 변경 시)

---

## 6. 본 정책의 출처

- 사용자 요청 (2026-05-20): "github 에 직접 commit & push 할 예정이니, contributor에 표시되지 않도록 co-auth를 표시하지 않도록 설정 필요."
- 메모리: `feedback_no_coauthor` (Claude 측 영구 메모리)
