# 개인 서버 배포 (private-deploy)

`subin21cc/sudo-capstone-project` 의 `private-deploy` 브랜치에서만 쓰는 배포 자료다.
upstream `CSE-Sudo/on-care` 에는 어떤 변경도 올리지 않는다.

## 구성

```
사용자 ─ https://flc.tailf0d4a.ts.net ─ Tailscale Funnel (TLS 종료)
        └─ nginx 127.0.0.1:8090
             ├─ /frontend/  /trainer/  /legal/   정적 파일 (/srv/oncare/www)
             └─ /v1/  → 앱 컨테이너 127.0.0.1:8000 ─ Postgres(pgvector) 컨테이너
```

- 서버: `yoshi@flc.tailf0d4a.ts.net` (Ubuntu 20.04), 저장소 `~/oncare`
- 첨부(채팅 사진·리포트 PDF): `/srv/oncare/data` (컨테이너 `/data`, 소유자 uid 10001)
- AI(Gemini)는 쓰지 않는다: `ALLOW_PROD_WITHOUT_AI=true` — 사진 분석 503, 코치·조언은 규칙형 폴백
- 메일은 쓰지 않는다: `ALLOW_PROD_WITHOUT_MAIL=true` + `SIGNUP_EMAIL_VERIFICATION=false`, 프론트는 `SIGNUP_EMAIL_CODE=false` — 가입에 인증 코드 없음, 비밀번호 재설정 메일 없음

## 브랜치

| 브랜치 | 역할 |
|---|---|
| `main` | upstream main 의 그대로 복사본. 직접 커밋하지 않는다 |
| `private-deploy` | `main` + 개인 배포 커밋 (`deploy/`, 백엔드·프론트 옵션) |

upstream 반영:

```bash
git fetch upstream
git switch main && git merge --ff-only upstream/main && git push origin main
git switch private-deploy && git merge main && git push origin private-deploy
```

`upstream` remote 의 push 주소는 `DISABLE` 로 막아 둔다.

## 배포

백엔드 (서버):

```bash
ssh yoshi@flc.tailf0d4a.ts.net 'bash ~/oncare/deploy/server-deploy.sh'
```

프론트 (로컬 Mac, Flutter 3.44.9):

```bash
bash deploy/frontend.sh
```

## 최초 1회 설정 (서버)

1. `git clone -b private-deploy https://github.com/subin21cc/sudo-capstone-project.git ~/oncare`
2. `cp deploy/env.private.example backend/.env` 후 `POSTGRES_PASSWORD`·`JWT_SECRET`·카카오 채우기
3. `sudo install -d -o yoshi /srv/oncare/www && sudo install -d -o 10001 -g 10001 /srv/oncare/data`
4. `sudo ln -sf ~/oncare/deploy/nginx/oncare.conf /etc/nginx/sites-enabled/oncare.conf && sudo nginx -t && sudo systemctl reload nginx`
5. `sudo tailscale funnel --bg http://127.0.0.1:8090` (관리 콘솔에서 HTTPS 인증서·Funnel 허용 필요)
6. `bash deploy/server-deploy.sh`

## 백엔드 추가 옵션 (private-deploy 에만 있음)

| 설정 | 효과 |
|---|---|
| `ALLOW_PROD_WITHOUT_AI` | env=prod 에서 AI 키 없이 기동 |
| `ALLOW_PROD_LOCAL_ATTACHMENTS` | env=prod 에서 첨부를 로컬(호스트 볼륨)에 저장 |
| `ALLOW_PROD_WITHOUT_MAIL` | env=prod 에서 `SIGNUP_EMAIL_VERIFICATION=false` 허용 |

프론트 빌드 옵션 `SIGNUP_EMAIL_CODE=false`: 가입 화면의 이메일 인증 단계를 숨긴다(두 앱 공통).
