# Project Specification: AI-Bird (Hackathon MVP Edition)

## 1. Project Overview
- **Project Name**: AI-Bird
- **Target Audience**: Users aged 40+ (Focus on visual accessibility, intuitive UX, and reduction of cognitive load)
- **Core Concept**: A gamified learning app where a "Bird" companion helps users master AI tools (prompting, image analysis, etc.) through daily step-by-step missions.
- **Hackathon Goal**: Deliver a fully working, zero-latency Web demo for presentation within 2 hours.

## 2. Technical Stack (MVP / Fast-Track)
| Category | Technology | Purpose (Hackathon) |
| :--- | :--- | :--- |
| **Platform** | Flutter Web | Optimized for rapid development in WSL2 and flawless browser presentations. |
| **State Management** | Signals | Modern, lean, and highly responsive. Minimal boilerplate compared to Provider/Riverpod. |
| **Structure** | Feature-First | Scalable directory structure (`features/mission`, `features/bird`). |
| **Backend/DB** | Mock (In-Memory) | Zero network latency/error risk during presentation. Hardcoded JSON models with `Future.delayed` to simulate loading. |
| **AI Orchestration** | Client-side Vertex AI / Mock | Direct client-to-API calls for the demo, or hardcoded mock responses for 100% presentation reliability. |
| **CI/CD** | GitHub Pages via Actions | Automated, always-deployable state for instant sharing. |
| **Animations** | Rive | Pre-built bird animations (Idle, Happy). |

## 3. UI/UX Principles (40+ Accessibility Focus)
- **Visuals**: Minimum 48x48dp touch targets; High-contrast (WCAG AA) colors; Large fonts.
- **Navigation**: Simple Bottom Navigation (Map / Shop / Profile).
- **Feedback**: Immediate visual (Bird animation) feedback.
- **Tone**: "Problem Solver" style.

## 4. Core System Architecture

### 4.1. Feature-First Structure
```text
lib/
 ┣ core/ (Theme, constants, mock_db)
 ┣ features/
 ┃ ┣ bird/ (Rive animation viewer, state)
 ┃ ┣ mission_map/ (Hardcoded mission tree UI)
 ┃ ┗ mission_runner/ (Dynamic slots: Text Coach, Image VQA)
 ┗ main.dart
```

### 4.2. Presentation Mission Scenarios
- The specific mission contents and logic for the presentation will be designed and implemented by the developer.

## 5. Mock Data Schema (In-Memory)

```dart
// lib/core/mock_db/mock_data.dart
final mockUser = {
  "uid": "test_user_01",
  "xp_total": 1250,
  "current_bird_id": "blue_swallow"
};

final List<Map<String, dynamic>> mockMissions = [
  // The developer will explicitly define the mock mission configurations.
];
```

## 6. Implementation Roadmap & Principles

**Core Development Principles:**
1. **Presentation First**: If something takes over 15 minutes to configure (like real Firebase Auth), mock it.
2. **Step-by-Step Quizzes**: The presentation video will focus on scenarios explicitly defined by the developer. Do not build an overarching dynamic system yet.

- **Phase 1: Foundation (0-30 min)**
  - `flutter create --platforms web ai_bird`
  - Setup Signals, folder structure (`core`, `features`).
  - Create the Mock DB file.
- **Phase 2: UI & Companion (30-60 min)**
  - Scaffold BottomNav and a static Mission Map.
  - Plop in the Rive animation for the bird.
- **Phase 3: Mission Runner & Polish (60-120 min)**
  - Build the Mission Runner UI (Text Field + Bird response).
  - Tie Signals to update XP after a mission.
  - Deploy to GitHub Pages.
