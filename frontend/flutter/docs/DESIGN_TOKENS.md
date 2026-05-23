# Oncare Flutter — 디자인 토큰 (Working Draft)

> **Status: 🚧 Placeholder** — Figma 원본([on-care prototype](https://www.figma.com/design/QdkC6pS5Fqep9TtGIWzhQg/on-care-prototype-))에 접근 가능해진 시점, 또는 Stage 3 진입 시점에 값을 확정합니다.
> 본 문서는 토큰의 **이름과 슬롯 구조**만 먼저 잡아두기 위함이며, 실제 색상/타이포/스페이싱 수치는 임시 디폴트(Material 3 기반)입니다.

---

## 1. 컬러

### 1.1 Brand
| 토큰 | 슬롯 | 임시값 | 비고 |
| --- | --- | --- | --- |
| `brand.primary` | 메인 강조 (CTA, active state) | `#3F8EFC` | Figma에서 추출 후 교체 |
| `brand.primaryContainer` | primary on container | `#D9E8FF` | |
| `brand.secondary` | 보조 강조 | `#5FD3A4` | |
| `brand.accent` | 알림/경고 액션 | `#FF8A65` | |

### 1.2 Semantic
| 토큰 | 슬롯 | 임시값 |
| --- | --- | --- |
| `semantic.success` | 긍정 피드백 | `#34A853` |
| `semantic.warning` | 주의 | `#FBBC05` |
| `semantic.error` | 실패 / 경고 | `#EA4335` |
| `semantic.info` | 정보 | `#4285F4` |

### 1.3 Neutral (Surface / Text)
| 토큰 | 슬롯 | 임시값 |
| --- | --- | --- |
| `surface.background` | 페이지 배경 | `#FFFFFF` (light) / `#0E1116` (dark) |
| `surface.card` | 카드 표면 | `#F7F8FA` / `#161A21` |
| `surface.divider` | 구분선 | `#E5E7EB` / `#2A2F36` |
| `text.primary` | 본문 강조 | `#111827` / `#F3F4F6` |
| `text.secondary` | 본문 보조 | `#4B5563` / `#9CA3AF` |
| `text.disabled` | 비활성 | `#9CA3AF` / `#4B5563` |

### 1.4 Domain (Oncare 특화)
| 토큰 | 슬롯 | 임시값 |
| --- | --- | --- |
| `domain.diet` | 식단 카드 액센트 | `#FFB74D` |
| `domain.exercise` | 운동 카드 액센트 | `#4DB6AC` |
| `domain.health` | 건강 카드 액센트 | `#7986CB` |
| `domain.aiCoach` | AI 코치 액센트 | `#9575CD` |

---

## 2. 타이포그래피

기본 폰트: **Pretendard** (한국어 지원 우수) 또는 **Noto Sans KR**. 영문은 시스템 기본.

| 토큰 | 용도 | 임시 size / weight / lh |
| --- | --- | --- |
| `typo.displayLg` | 대형 타이틀 | 36 / 700 / 1.2 |
| `typo.displayMd` | 페이지 타이틀 | 28 / 700 / 1.25 |
| `typo.titleLg` | 카드 타이틀 | 20 / 600 / 1.3 |
| `typo.titleMd` | 섹션 타이틀 | 18 / 600 / 1.3 |
| `typo.bodyLg` | 본문 강조 | 16 / 500 / 1.45 |
| `typo.bodyMd` | 본문 | 14 / 400 / 1.5 |
| `typo.caption` | 보조 텍스트 | 12 / 400 / 1.4 |
| `typo.button` | 버튼 라벨 | 14 / 600 / 1.0 |
| `typo.metricLg` | 큰 지표 숫자 | 32 / 700 / 1.1 (tabular-nums) |
| `typo.metricMd` | 작은 지표 숫자 | 20 / 600 / 1.1 (tabular-nums) |

---

## 3. 스페이싱 / 사이즈

8pt grid 기반.

| 토큰 | 값 |
| --- | --- |
| `space.xxs` | 2 |
| `space.xs` | 4 |
| `space.sm` | 8 |
| `space.md` | 12 |
| `space.lg` | 16 |
| `space.xl` | 24 |
| `space.xxl` | 32 |
| `space.xxxl` | 48 |

---

## 4. 라운드 (Border Radius)

| 토큰 | 값 |
| --- | --- |
| `radius.xs` | 4 |
| `radius.sm` | 8 |
| `radius.md` | 12 |
| `radius.lg` | 16 |
| `radius.xl` | 24 |
| `radius.pill` | 999 |

---

## 5. 엘리베이션 / 그림자

| 토큰 | 용도 | 임시값 |
| --- | --- | --- |
| `elevation.0` | flat | none |
| `elevation.1` | 카드 기본 | `0 1px 2px rgba(0,0,0,0.06)` |
| `elevation.2` | hover/floating | `0 4px 12px rgba(0,0,0,0.08)` |
| `elevation.3` | dialog | `0 12px 32px rgba(0,0,0,0.16)` |

---

## 6. 모션 / 듀레이션

| 토큰 | 값 | 용도 |
| --- | --- | --- |
| `motion.fast` | 120ms | 마이크로 인터랙션 (체크박스 등) |
| `motion.base` | 220ms | 일반 트랜지션 |
| `motion.slow` | 360ms | 페이지 / 모달 |
| `motion.curve.standard` | `Curves.easeInOut` | 기본 곡선 |
| `motion.curve.emphasized` | `Curves.easeOutCubic` | 등장 |

---

## 7. 브레이크포인트 (Web/태블릿 대비)

| 토큰 | 너비 | 레이아웃 |
| --- | --- | --- |
| `bp.mobile` | `< 600` | 1 column, BottomNav |
| `bp.tablet` | `600 ~ 1024` | 2 column, NavigationRail |
| `bp.desktop` | `≥ 1024` | 3 column, side nav + content + side panel |

---

## 8. 매핑 — Material 3 ColorScheme

| 토큰 | M3 슬롯 |
| --- | --- |
| `brand.primary` | `primary` |
| `brand.primaryContainer` | `primaryContainer` |
| `brand.secondary` | `secondary` |
| `semantic.error` | `error` |
| `surface.background` | `surface` |
| `surface.card` | `surfaceContainerHigh` |
| `text.primary` | `onSurface` |
| `text.secondary` | `onSurfaceVariant` |

→ Stage 3.1에서 `design_system/tokens/colors.dart` 로 코드화.

---

## 9. 후속 작업

- [ ] Figma 접근 후 1.1~1.4 컬러 실값으로 교체
- [ ] Figma의 typography 스타일에서 size/lh/letter-spacing 추출
- [ ] dark 모드 토큰 변형 정의
- [ ] light/dark 자동 매핑 룰 합의
- [ ] `design_system/tokens/` 하위 dart 파일로 동기화
