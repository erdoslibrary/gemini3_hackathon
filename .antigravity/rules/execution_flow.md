# Execution Flow (Hackathon MVP)

This document outlines the exact, step-by-step execution flow for building the AI-Bird app within the 2-hour hackathon timeframe. Each phase must be completed and manually verified before moving on. Stick strictly to the `specification.md`.

## Phase 1: Foundation Setup (0-30 min)

### 1.1 Project Initialization
1. Ensure you are inside the generated `ai_bird` directory.
2. Clear the default `lib/main.dart` code to start fresh.
3. Install required dependencies:
   `flutter pub add signals google_fonts rive`

### 1.2 Feature-First Structure
Create the following directory skeleton inside `lib/`:
```text
lib/
 ┣ core/
 ┃ ┣ theme/
 ┃ ┣ constants/
 ┃ ┗ mock_db.dart
 ┣ features/
 ┃ ┣ bird/          # Rive animation widget & state
 ┃ ┣ mission_map/   # Hardcoded UI for the Map tab
 ┃ ┣ mission_runner/# The UI where the active mission happens
 ┃ ┗ shop/          # Hardcoded UI for the Shop tab
 ┗ main.dart
```

### 1.3 Core Configuration
1. **Mock Data**: Create `lib/core/mock_db.dart` and populate it with the user's initial dummy state (XP: 0).
2. **Signals Setup**: In `lib/core/state.dart` (or within feature files), declare global signals, e.g., `final userXp = signal(0);`.
3. **App Styling**: In `main.dart`, define a basic `MaterialApp` with a cohesive, accessible `ThemeData` (min font size 18pt, high contrast).

## Phase 2: Essential UI Assembly (30-70 min)

### 2.1 The Scaffold (Bottom Navigation)
1. Create a `MainScreen` widget containing a `BottomNavigationBar` with 3 items: **Map, Mission, Shop**.
2. Manage the selected tab index using a Signal (`final currentTab = signal(0);`).
3. Connect the body of the `Scaffold` to display the corresponding feature view.

### 2.2 Bird Animation Widget
1. Place a `.riv` file (if available, else use a colored placeholder container temporarily) in the `assets/` folder and update `pubspec.yaml`.
2. Create `BirdCompanionWidget` inside `features/bird/`.
3. Ensure the widget accepts a state enum (e.g., `Idle`, `Thinking`, `Happy`) to trigger different Rive animations.

### 2.3 The Mock Map & Shop
1. **Map View**: Implement a simple vertically scrolling list or `Stack` with hardcoded mission nodes (e.g., circles).
2. **Shop View**: Implement a simple grid showing different birds (or colors) that require XP to unlock. *(Visual only, logic is optional for MVP)*.

## Phase 3: The Mission Runner (70-110 min)

*This is the core presentation piece.*

### 3.1 Mission Layout
1. Build the `MissionRunnerScreen`.
2. **Header**: Display current mission title and User XP (live reading from `userXp` signal).
3. **Mid Section**: Display the `BirdCompanionWidget`.
4. **Bottom Section**: A `TextField` for the user to type their simulated response (e.g., "What is the weather?").

### 3.2 Presentation Logic (The Hack)
Since AI and Database are mocked, write this specific flow:
1. User types in the `TextField` and presses submit.
2. Change Bird state to `Thinking`.
3. Use `await Future.delayed(Duration(seconds: 2))` to simulate AI processing.
4. Update `userXp.value += 500`.
5. Change Bird state to `Happy`.
6. Display a simulated success dialog to the user.

## Phase 4: Finalization & Deployment (110-120 min)

### 4.1 Polish
- Ensure minimum touch target sizes (48dp) are met.
- Ensure text is readable.
- Click through the complete 'Happy Path' to ensure no fatal exceptions occur.

### 4.2 Web Build
1. Run `flutter build web --release`.
2. Prepare to host the `build/web/` directory using GitHub Pages, Vercel, or locally using `python3 -m http.server` for the presentation.
