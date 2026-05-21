<div align="center">

<br/>

# 🩺 On-Care
### HealthMate AI: 불규칙한 생활 속 2030을 위한 고혈압·당뇨 위험군 대상 식단 인식·코칭 통합 헬스케어 플랫폼

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?style=flat-square&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![YOLOv8](https://img.shields.io/badge/YOLOv8-Image_Filtering-FF6B35?style=flat-square&logo=pytorch&logoColor=white)](https://github.com/ultralytics/ultralytics)
[![Gemini](https://img.shields.io/badge/Gemini_API-Vision_AI-4285F4?style=flat-square&logo=google&logoColor=white)](https://ai.google.dev)
[![GPT-4o](https://img.shields.io/badge/GPT--4o-RAG_Pipeline-412991?style=flat-square&logo=openai&logoColor=white)](https://openai.com)

<br/>

> **2026 이화여자대학교 컴퓨터공학전공 캡스톤디자인**
> **[Team02] Sudo**

<br/>

</div>

---

## 📌 Overview

2030세대 만성질환(고혈압·당뇨·이상지질혈증) 유병률이 구조적으로 급증하는 가운데, 기존 헬스케어 앱은 **식단·운동·일정의 파편화**와 **획일적 정보 제공**이라는 한계를 벗어나지 못하고 있습니다.

**On-Care**는 이 문제를 정면으로 해결합니다.

- **YOLOv8 + Gemini Vision API** 2단계 파이프라인으로 식단 자동 인식의 정확도와 효율을 동시에 확보하고
- **RAG(Retrieval-Augmented Generation)** 아키텍처로 사용자 개인 건강 이력을 LLM에 연결해 *'내 데이터를 아는 AI 코치'* 를 구현하며
- 식단·운동·상담·헬스장·일정을 **단일 플랫폼**에서 통합 제공합니다

<br/>

## ✨ Key Features

| 기능 | 설명 | 핵심 기술 |
|------|------|-----------|
| **Vision AI 식단 자동 인식** | 음식 사진 1장으로 식품 종류·섭취량·칼로리·영양소 자동 분석 및 기록 | YOLOv8 (음식 필터링) + Gemini Vision API (영양 분석), 공공데이터 식품영양성분 DB |
| **RAG 기반 AI 헬스 챗봇** | 사용자 건강 이력 Vector DB를 GPT-4o에 컨텍스트로 주입, 개인 맞춤 코칭 제공 | LangChain, Pinecone, GPT-4o |
| **AI 맞춤 운동 코칭** | 체력·목적·건강 상태 기반 운동 루틴 생성, 피드백 반영 동적 재조정 | LLM + 규칙 기반 하이브리드 |
| **헬스장 검색 & 트레이너 연동** | 위치 기반 헬스장 검색·예약·트레이너 인앱 채팅, AI 사용자 데이터 자동 요약 전달 | 카카오맵 API |
| **통합 건강 일정 관리** | 식단·운동·병원 예약·건강검진 캘린더 통합, 실시간 푸시 알림 | FCM |
| **게이미피케이션 보상 시스템** | 활동 포인트·Streak 보상, 프리미엄 기능과 교환 가능 | — |

<br/>

## 🏗️ System Architecture

```
┌──────────────────────────────────────────────────────────────────┐
│               Flutter Mobile App (iOS / Android)                 │
│        카메라 · 식단 · RAG 챗봇 · 운동 · 헬스장 · 포인트 · 캘린더          │
└──────────────────────────┬───────────────────────────────────────┘
                           │  HTTPS REST API
┌──────────────────────────▼───────────────────────────────────────┐
│              FastAPI Backend  (Docker / AWS EC2)                 │
│        인증 JWT · 식단 API · 운동 API · RAG Pipeline · 포인트 관리     │
└──────┬──────────────────┬─────────────────────────┬──────────────┘
       │                  │                         │
┌──────▼──────┐  ┌────────▼──────────────┐  ┌──────▼───────────────┐
│  MySQL RDS  │  │  Vision AI Pipeline   │  │    RAG Pipeline      │
│   사용자·식단  │  │  YOLOv8 (1차 필터링)    │  │  LangChain+Pinecone  │
│  운동·포인트   │  │  → Gemini Vision API  │  │  GPT-4o API          │
└─────────────┘  │    (영양 분석)          │  └──────────────────────┘
                 └───────────────────────┘
                           │
┌──────────────────────────▼───────────────────────────────────────┐
│                      External APIs                               │
│   카카오맵 API · 공공데이터 식품영양성분 DB · Google AI · OpenAI · FCM   │
└──────────────────────────────────────────────────────────────────┘
```

<br/>

## 🍽️ Vision AI 식단 인식 Pipeline

사진 한 장이 어떻게 영양 정보로 변환되는지:

```
사용자 식단 사진 업로드
      │
      ▼
  [1] YOLOv8 — 음식 이미지 1차 필터링
      │  → 음식으로 분류된 경우만 다음 단계로 진행
      │  → 음식이 아닌 경우 즉시 반려 (API 비용 절감 · 응답 속도 향상)
      │
      ▼
  [2] Gemini Vision API — 상세 음식 분석
      │  → 음식 종류 식별 · 추정 섭취량 분석
      │
      ▼
  [3] 공공데이터 식품영양성분 DB 매핑
      │  → 칼로리 · 탄수화물 · 단백질 · 지방 · 나트륨 등 영양소 계산
      │
      ▼
  [4] 식단 기록 저장 (MySQL RDS)
      │
      ▼
  "닭볶음밥 1인분 (450kcal) · 탄수화물 62g · 단백질 18g · 지방 14g"
```

> **YOLOv8으로 음식 여부를 먼저 판별**해 불필요한 Gemini API 호출을 차단하고, 음식으로 확인된 이미지에 한해 **Gemini Vision API로 세밀한 영양 분석**을 수행하는 2단계 구조가 핵심입니다.

<br/>

## 🤖 RAG Pipeline

사용자의 질문이 어떻게 개인화된 답변으로 변환되는지:

```
사용자 질문 "오늘 식단 괜찮아?"
      │
      ▼
  [1] 임베딩 (text-embedding-3-small)
      │
      ▼
  [2] Vector DB Semantic Search (Pinecone)
      │  → 인바디 이력 · 이번 주 식단 기록 · 운동 로그 · 질환 정보 · 목표 설정
      │
      ▼
  [3] GPT-4o 컨텍스트 주입 → 맞춤 답변 생성
      │
      ▼
  "최근 3일간 탄수화물 목표 대비 12% 초과.
   저녁에 닭가슴살 샐러드를 추천드립니다."
```

> 단순 일반 정보가 아닌 **'내 이번 주 기록 기준' 맞춤 조언**이 핵심 차별점입니다.

<br/>

## 🛠️ Tech Stack

### AI / ML
![YOLOv8](https://img.shields.io/badge/YOLOv8-Food_Image_Filtering-FF6B35?style=flat-square)
![Gemini Vision API](https://img.shields.io/badge/Gemini_Vision_API-Nutrition_Analysis-4285F4?style=flat-square)
![GPT-4o](https://img.shields.io/badge/GPT--4o-LLM-412991?style=flat-square)
![LangChain](https://img.shields.io/badge/LangChain-RAG_Framework-1C3C3C?style=flat-square)
![Pinecone](https://img.shields.io/badge/Pinecone-Vector_DB-00B4A2?style=flat-square)
![PyTorch](https://img.shields.io/badge/PyTorch-Inference_Server-EE4C2C?style=flat-square)

### Mobile
![Flutter](https://img.shields.io/badge/Flutter-Cross_Platform-02569B?style=flat-square)
![Riverpod](https://img.shields.io/badge/Riverpod-State_Management-00AAFF?style=flat-square)
![Dart](https://img.shields.io/badge/Dart-Language-0175C2?style=flat-square)

### Backend
![FastAPI](https://img.shields.io/badge/FastAPI-REST_Server-009688?style=flat-square)
![MySQL](https://img.shields.io/badge/MySQL-AWS_RDS-4479A1?style=flat-square)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?style=flat-square)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI/CD-2088FF?style=flat-square)

### Cloud & Infra
![Firebase](https://img.shields.io/badge/FCM-Push_Notification-FFCA28?style=flat-square)

### External APIs
![KakaoMap](https://img.shields.io/badge/Kakao_Map-Location_Service-FFCD00?style=flat-square)
![Google AI](https://img.shields.io/badge/Google_AI-Gemini_API-4285F4?style=flat-square)
![공공데이터](https://img.shields.io/badge/공공데이터포털-식품영양성분_DB-0066CC?style=flat-square)

<br/>


## 📊 Competitive Analysis

On-Care는 기존 헬스케어 플랫폼의 공백(Pain Point)을 정확히 공략하여 Product-Market Fit을 달성합니다.

| 비교 항목 | 삼성헬스 (Samsung Health) | 필라이즈 (Pillyze) | 밀리그램 / 인아웃 | **On-Care** |
| :--- | :--- | :--- | :--- | :--- |
| **식단 기록 방식** | 직접 검색 및 수동 입력 (진입 장벽 높음) | 사진 기반 AI 인식 (오인식 시 보정 피로도) | 사진 저장, 빠른 입력 위주 | **사진 1장 → YOLOv8 1차 필터링 + Gemini Vision 영양 분석 + 공공데이터 자동 매핑** |
| **한국 음식 정확도** | 보통 | 보통 | 낮음 (사용자 등록 의존) | **높음 (공공데이터 식품영양성분 DB 기반 검증)** |
| **AI 코칭 방식** | 활동 데이터 기반 단편적 해석 | AI 코치 + 전문가 Q&A (실시간 맥락 참조 한계) | 소셜 및 챌린지 동기부여 중심 (체중 감량 집중) | **RAG 기반 개인 식단·운동·질환 이력 실시간 참조 맥락 코칭** |
| **만성질환 특화** | 없음 (범용 건강 관리) | 일부 기능 (혈당 연동 등) | 없음 (다이어트 제한 식단 중심) | **2030 고혈압·당뇨 위험군 중심 설계 (나트륨 경고, GI 지수 분류, 불규칙 패턴 감지)** |
| **오프라인 연결** | 없음 | 없음 | 없음 | **카카오맵 기반 헬스장 검색·예약·트레이너 채팅 + 건강 데이터 자동 요약 전달 (O2O)** |
| **플랫폼 독립성** | 갤럭시 기기 및 생태계 종속 | iOS / Android | iOS / Android | **Flutter 기반 iOS / Android 완벽히 동일한 사용자 경험** |

<br/>

## 👥 Team Sudo

|                          최지수                          |                            박서연                             |                           신수빈                            |
|:-----------------------------------------------------:|:----------------------------------------------------------:|:--------------------------------------------------------:|
| <img src="https://github.com/aJISUa.png" width="100"> | <img src="https://github.com/seoyeon0516.png" width="100"> | <img src="https://github.com/subin21cc.png" width="100"> |
|         [@aJISUa](https://github.com/aJISUa)          |       [@seoyeon0516](https://github.com/seoyeon0516)       |        [@subin21cc](https://github.com/subin21cc)        |

> 지도교수: 황의원 교수님 · 이화여자대학교 컴퓨터공학전공

<!--
<br/>

## 📁 Repository Structure

```
sudo-capstone-project/
├── mobile/                    # Flutter 모바일 앱
│   ├── lib/
│   │   ├── features/       # 기능별 모듈 (식단, 운동, 챗봇, 헬스장, 캘린더)
│   │   ├── core/           # 공통 유틸리티, 라우팅, 테마
│   │   └── main.dart
│   └── pubspec.yaml
├── backend/                # FastAPI 백엔드 서버
│   ├── api/                # 라우터 및 엔드포인트
│   ├── services/           # 비즈니스 로직 (Vision AI Pipeline, RAG 연동)
│   ├── models/             # DB 모델
│   └── main.py
├── ai/
│   ├── vision/             # YOLOv8 음식 필터링 모델 · Gemini Vision API 연동
│   └── rag/                # RAG 파이프라인 (LangChain + Pinecone)
├── infra/                  # Docker, CI/CD (GitHub Actions)
└── docs/                   # 설계 문서, API 명세
```
-->

<br/>

---

<div align="center">

**2026 이화여자대학교 캡스톤디자인**

*Team Sudo — Jisu Choi · Seoyeon Park · Subin Shin*

</div>
