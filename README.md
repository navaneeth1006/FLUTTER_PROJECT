# 🌿 EcoSteps – Animated Recycling Guide & Privacy AI

[![Flutter](https://img.shields.io/badge/Flutter-3.47.8-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13.7-0175C2?logo=dart)](https://dart.dev)
[![Material Design 3](https://img.shields.io/badge/UI-Material%203-10B981)](https://m3.material.io)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**EcoSteps** is a production-ready, multiplatform Flutter application that teaches users how to recycle waste correctly through an interactive, visually stunning step-by-step guide. Built using Flutter's core animation primitives—including `FadeTransition`, `SlideTransition`, and `Hero` animations—EcoSteps delivers smooth, responsive transitions between screens and recycling phases.

The application also preserves the on-device **Privacy-First AI Assistant**, combining environmental education with local, offline privacy preservation.

---

## 🌟 Core Features

- ♻️ **Interactive 6-Step Recycling Guide**: Complete workflow covering collection, separation, cleaning, municipal sorting, processing, and circular reduction.
- 🎬 **Fluid Built-in Animations**:
  - **`FadeTransition`**: Smoothly fades welcome elements, headers, and recap cards using `CurvedAnimation`.
  - **`SlideTransition`**: Enters instruction cards, tips, and items using `Curves.easeOutCubic`.
  - **`Hero` Animations**: Seamless icon flight transitions from overview cards to high-detail step views without visual popping or duplicate tag collisions.
- 📊 **Animated Progress Tracking**: Interactive progress indicator with animated progress track and step navigation dots.
- 💡 **Actionable Eco Tips & Material Checklists**: Clear lists of accepted recyclables, practical household tips, and contamination warnings ("Keep Out").
- ♿ **Accessibility & Motion Preferences**: Fully supports reduced-motion system preferences (`MediaQuery.disableAnimations`) and manual in-app motion toggles.
- 📱 **Multiplatform**: Runs cleanly across Web, Android, iOS, Windows, macOS, and Linux.
- 🔒 **Preserved Privacy AI Assistant**: Fast, 100% on-device AI assistant accessible via Settings.

---

## 📋 The 6 Recycling Steps

| Step | Title | Focus Area | Key Guidance |
|---|---|---|---|
| **1** | **Collect Waste** | Household Collection | Set up dedicated collection bins for paper, cardboard, rigid plastics (#1, #2), glass, and metals. |
| **2** | **Separate Materials** | Polymer & Fiber Sorting | Group items by material type; check plastic resin identification codes (#1–#7). |
| **3** | **Clean and Dry** | Sanitization | Empty liquids, scrape residues, rinse with leftover dishwater, and dry to protect paper batches. |
| **4** | **Sort Correctly** | Municipal Alignment | Match municipal color-coded bins (Blue, Yellow, Green) and avoid wish-cycling tanglers. |
| **5** | **Send for Recycling** | Recovery & Transport | Flatten cardboard boxes, observe curbside schedules, or visit local recycling depots. |
| **6** | **Reuse and Reduce** | Circular Living | Practice the 5 R’s: Refuse single-use plastics, Reduce consumption, and Reuse containers. |

---

## 🏗️ Project Architecture

```
PrivacyPreservingchatbot/
├── .github/
│   └── workflows/
│       └── flutter_ci.yml              # CI/CD automated test & GitHub Pages deploy
├── android/                            # Android platform files
├── ios/                                # iOS platform files
├── web/                                # Web platform entry & PWA manifest
├── windows/                            # Windows desktop runner
├── macos/                              # macOS desktop runner
├── linux/                              # Linux desktop runner
├── lib/
│   ├── main.dart                       # App entrypoint (initializes services & EcoStepsApp)
│   ├── app.dart                        # MaterialApp configuration, themes, & routes
│   ├── models/
│   │   ├── recycling_step.dart         # RecyclingStep data model
│   │   ├── personal_data.dart          # Chatbot personal data model
│   │   └── chat_message.dart           # Chatbot message model
│   ├── data/
│   │   └── recycling_steps.dart        # 6 core recycling steps dataset
│   ├── screens/
│   │   ├── welcome_screen.dart         # Hero welcome screen with branding & CTAs
│   │   ├── home_screen.dart            # Overview of steps with hero cards & progress
│   │   ├── recycling_step_screen.dart  # Detailed step guide with PageView & controls
│   │   ├── completion_screen.dart      # Celebration, recap cards, and restart actions
│   │   ├── settings_screen.dart        # Motion toggles, disclaimers, & AI chatbot link
│   │   └── chat_screen.dart            # Preserved Privacy AI Chatbot screen
│   ├── widgets/
│   │   ├── recycling_step_card.dart    # Home screen hero preview card
│   │   ├── animated_step_content.dart  # Step instructions, tips, and checklists
│   │   ├── recycling_progress.dart     # Animated progress indicator & step dots
│   │   └── primary_button.dart         # Reusable styled button with accessible states
│   ├── animations/
│   │   ├── fade_animation.dart         # Reusable FadeTransition wrapper
│   │   ├── slide_animation.dart        # Directional SlideTransition wrapper
│   │   └── hero_recycling_icon.dart    # Hero widget with flight shuttle builder
│   ├── services/                       # Preserved on-device AI & storage services
│   └── theme/
│       └── app_theme.dart              # Material 3 eco-friendly light & dark themes
├── test/
│   ├── recycling_steps_test.dart       # Unit tests for dataset, numbering, & boundaries
│   ├── widget_test.dart                # Widget tests for screens, cards, & navigation
│   └── animation_test.dart             # Animation tests for Fade, Slide, Hero, & disposal
├── pubspec.yaml                        # Project dependencies and configuration
├── DEPLOYMENT.md                       # Comprehensive deployment & platform guide
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.19.0 or newer (Stable channel)
- Dart SDK 3.3.0 or newer

### Installation
```bash
# Clone the repository
git clone https://github.com/Syamprasad1212/PrivacyPreservingchatbot.git
cd PrivacyPreservingchatbot

# Fetch dependencies
flutter pub get
```

### Running Locally
```bash
# Run on default connected device
flutter run

# Run on Google Chrome (Web)
flutter run -d chrome

# Run on Windows Desktop
flutter run -d windows
```

---

## 🧪 Automated Testing & Code Quality

EcoSteps includes comprehensive unit, widget, and animation tests:

```bash
# Check formatting
dart format --output=none --set-exit-if-changed lib test

# Static analysis
flutter analyze

# Execute all test suites
flutter test
```

### Test Coverage Highlights
1. **`test/recycling_steps_test.dart`**:
   - Confirms exactly 6 recycling steps exist with non-empty titles, tips, and items.
   - Validates sequential 1–6 numbering and collision-free unique Hero tags.
   - Verifies boundary handling and progress calculation accuracy.
2. **`test/widget_test.dart`**:
   - Verifies Welcome Screen rendering and actions.
   - Verifies Home Screen displays all 6 step cards.
   - Validates interactive Next/Previous navigation and boundary disabling.
   - Validates that Step 6 advances to the Completion Screen and Restart resets to Step 1.
3. **`test/animation_test.dart`**:
   - Validates `FadeAnimation` opacity tween interpolation.
   - Validates `SlideAnimation` directional offsets and settlement.
   - Verifies `HeroRecyclingIcon` tag assignment.
   - Confirms smooth disposal of `AnimationController`s without exceptions.

---

## 📦 Building for Production

```bash
# Web production build
flutter build web --release

# Web build with GitHub Pages base path
flutter build web --release --base-href "/PrivacyPreservingchatbot/"

# Android APK
flutter build apk --release

# Windows Desktop
flutter build windows --release
```

For complete platform guides, see **[DEPLOYMENT.md](DEPLOYMENT.md)**.

---

## 🔒 Preserved Privacy AI Chatbot

The repository's offline **Privacy-First AI Assistant** remains fully functional. It can be accessed directly from **Settings & Info > Associated Tools > Privacy AI Assistant** or used for on-device document search and natural language queries without sending data to third-party clouds.

---

## 📄 License

This project is licensed under the MIT License.
