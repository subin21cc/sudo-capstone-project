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

2030세대의 만성질환(고혈압·당뇨) 유병률이 최근 5년간 각각 28%, 38% 급증하는 구조적 위험 속에서, 기존 헬스케어 앱들은 **식단 기록의 높은 피로도**, **개인 건강 이력을 반영하지 못하는 획일적 조언**, **온·오프라인 관리 환경의 단절**이라는 공통적인 한계를 가집니다.

**On-Care**는 이 문제를 기술적 혁신으로 정면 해결하는 **통합 O2O 헬스케어 생태계**입니다.

- **YOLOv8 + Gemini Vision API** 2단계 파이프라인으로 식단 자동 인식의 정확도와 비용 효율을 동시에 확보합니다.
- **RAG(Retrieval-Augmented Generation)** 아키텍처로 사용자의 건강 이력, 식단·운동 로그를 실시간 참조하는 초개인화 맥락 코칭을 구현합니다.
- **카카오맵 API 기반 O2O 연동**을 통해 앱 내 건강 데이터를 오프라인 트레이너에게 자동 요약 전달하여 끊김 없는 케어를 제공합니다.
- **Flutter 기반 크로스 플랫폼** 빌드로 iOS와 Android 환경 모두에서 완벽히 동일한 사용자 경험을 보장합니다.

> 💡 **실사용자 인터뷰 (Customer Discovery) 요약**
> * **대상:** 20~30대 만성질환 환자, 위험군 및 운동 병행 사용자 3인
> * **핵심 발견:** 인터뷰이 전원이 기존 앱을 3일 이상 지속하지 못함. 원인은 **"매끼 수동 입력의 번거로움"**과 **"기록 노력 대비 행동 변화를 유도하는 실질적인 피드백의 부재"**로 귀결됨. 만성질환자에게 필요한 것은 단순 칼로리 추적이 아닌, **'무엇을 피해야 하는가'에 대한 맥락적 조언**임이 실증됨.

<br/>

## ✨ Key Features

| 기능 | 설명 | 핵심 기술 |
|------|------|-----------|
| **Vision AI 식단 자동 인식** | 음식 사진 1장으로 식품 종류·섭취량·칼로리·영양소 자동 분석 및 기록. 공공데이터 식품영양성분 DB 매핑으로 높은 한국 음식 정확도 보장 | YOLOv8 (1차 필터링) + Gemini Vision API (영양 분석), 공공데이터 식품영양성분 DB |
| **RAG 기반 초개인화 AI 코칭** | 사용자 건강 이력 Vector DB를 GPT-4o에 컨텍스트로 주입, 누적 이력 기반의 맥락적 조언 및 질환 특화 가드레일 적용 | LangChain, Pinecone, GPT-4o |
| **2030 만성질환 특화 관리** | 고혈압·당뇨 위험군 중심 설계. 나트륨 섭취량 정밀 추적, GI 지수 기반 식품 자동 분류 및 대체 식품 추천, 불규칙 패턴 감지 | 규칙 기반 하이브리드 알고리즘 |
| **O2O 헬스장 & 트레이너 연동** | 위치 기반 헬스장 검색·예약·인앱 채팅. 트레이너 매칭 시 사용자의 동의 하에 앱 내 누적 건강 데이터 요약본 자동 전달 | 카카오맵 API |
| **통합 건강 일정 관리** | 식단·운동·병원 예약·건강검진 캘린더 통합, 실시간 푸시 알림 | FCM |
| **게이미피케이션 보상 시스템** | 야식 및 불규칙 식사 패턴 감지 스트릭(Streak) 보상 및 활동 포인트 시스템 | — |

<br/>

## 🏗️ System Architecture


```

┌──────────────────────────────────────────────────────────────────┐
│                 Flutter Mobile App (iOS / Android)               │
│         카메라 · 식단 · RAG 챗봇 · 운동 · 헬스장 · 포인트 · 캘린더          │
└──────────────────────────┬───────────────────────────────────────┘
│  HTTPS REST API
┌──────────────────────────▼───────────────────────────────────────┐
│         FastAPI Backend  (Docker / AWS EC2)                      │
│        인증 JWT · 식단 API · 운동 API · RAG Pipeline · 포인트 관리     │
└──────┬──────────────────┬─────────────────────────┬──────────────┘
│                  │                         │
┌──────▼──────┐  ┌────────▼──────────────┐  ┌──────▼───────────────┐
│  MySQL RDS  │  │  Vision AI Pipeline   │  │    RAG Pipeline      │
│   사용자·식단 │  │  YOLOv8 (1차 필터링)    │  │  LangChain+Pinecone  │
│  운동·포인트 │  │  → Gemini Vision API  │  │  GPT-4o API          │
└─────────────┘  │    (영양 분석)          │  └──────────────────────┘
└───────────────────────┘
│
┌──────────────────────────▼───────────────────────────────────────┐
│                       External APIs                              │
│   카카오맵 API · 공공데이터 식품영양성분 DB · Google AI · OpenAI · FCM   │
└──────────────────────────────────────────────────────────────────┘

```

<br/>

## 🍽️ Vision AI 식단 인식 Pipeline

사진 한 장이 어떻게 비용 효율적으로 영양 정보로 변환되는지 정의합니다:


```

사용자 식단 사진 업로드
│
▼
[1] YOLOv8 — 음식 이미지 1차 필터링
│  → 음식으로 분류된 경우만 다음 단계로 진행
│  → 음식이 아닌 경우 즉시 반려 (고비용 LLM API 호출 사전 차단 · 비용 절감)
│
▼
[2] Gemini Vision API — 상세 음식 분석
│  → 이미지 내 음식 종류 식별 및 추정 섭취량 분석
│
▼
[3] 공공데이터 식품영양성분 DB 매핑
│  → AI 분석 결과를 공공데이터 식품영양성분 DB와 매핑하여 한국 음식 영양 성분의 무결성 확보
│
▼
[4] 식단 기록 저장 (MySQL RDS)

```

<br/>

## 🤖 RAG Pipeline

사용자의 질문이 할루시네이션 없이 안전하고 맥락이 살아있는 답변으로 변환되는 구조입니다:


```

사용자 질문 "오늘 저녁 식단 어때?"
│
▼
[1] 질문 임베딩 (text-embedding-3-small)
│
▼
[2] Vector DB Semantic Search (Pinecone)
│  → 사용자의 인바디, 누적 식단/운동 로그, 질환 프로필 실시간 참조
│
▼
[3] GPT-4o 컨텍스트 주입 & 질환 특화 가드레일 적용
│  → 한국영양학회 등 공공 의료 지침 데이터(Closed-domain) 소스 기반 프롬프트 필터 작동
│
▼
"이번 주 탄수화물 목표를 이미 12% 초과하셨고 고혈압 위험군이시니,
나트륨이 적은 닭가슴살 샐러드를 추천합니다."

```

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

## 🛠️ Tech Stack

### Frontend
![Flutter](https://img.shields.io/badge/Flutter-Cross_Platform-02569B?style=flat-square&logo=flutter)
![Riverpod](https://img.shields.io/badge/Riverpod-State_Management-00AAFF?style=flat-square)
![Dart](https://img.shields.io/badge/Dart-Language-0175C2?style=flat-square&logo=dart)

### Backend
![FastAPI](https://img.shields.io/badge/FastAPI-REST_Server-009688?style=flat-square&logo=fastapi)
![MySQL](https://img.shields.io/badge/MySQL-AWS_RDS-4479A1?style=flat-square&logo=mysql)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?style=flat-square&logo=docker)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI/CD-2088FF?style=flat-square&logo=githubactions)

### AI & Database
![YOLOv8](https://img.shields.io/badge/YOLOv8-Food_Filtering-FF6B35?style=flat-square&logo=pytorch)
![Gemini Vision API](https://img.shields.io/badge/Gemini_Vision_API-Nutrition_Analysis-4285F4?style=flat-square&logo=google)
![GPT-4o](https://img.shields.io/badge/GPT--4o-LLM_RAG-412991?style=flat-square&logo=openai)
![LangChain](https://img.shields.io/badge/LangChain-RAG_Framework-1C3C3C?style=flat-square)
![Pinecone](https://img.shields.io/badge/Pinecone-Vector_DB-00B4A2?style=flat-square)

### Cloud & External APIs
![Firebase](https://img.shields.io/badge/FCM-Push_Notification-FFCA28?style=flat-square&logo=firebase)
![KakaoMap](https://img.shields.io/badge/Kakao_Map-Location_Service-FFCD00?style=flat-square)
![공공데이터](https://img.shields.io/badge/공공데이터포털-식품영양성분_DB-0066CC?style=flat-square)

<br/>

## 👥 Team Sudo

|                          최지수                          |                            박서연                             |                            신수빈                            |
|:-----------------------------------------------------:|:----------------------------------------------------------:|:--------------------------------------------------------:|
| <img src="https://github.com/aJISUa.png" width="100"> | <img src="https://github.com/seoyeon0516.png" width="100"> | <img src="https://github.com/subin21cc.png" width="100"> |
|         [@aJISUa](https://github.com/aJISUa)          |       [@seoyeon0516](https://github.com/seoyeon0516)       |        [@subin21cc](https://github.com/subin21cc)        |

> 지도교수: 황의원 교수님 · 이화여자대학교 컴퓨터공학전공

<br/>

---

<div align="center">

**2026 이화여자대학교 캡스톤디자인**

*Team Sudo — Jisu Choi · Seoyeon Park · Subin Shin*

</div>
