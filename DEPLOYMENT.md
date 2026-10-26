# Deployment & Operations Guide – EcoSteps

This document outlines the prerequisites, local development workflow, build steps, and production deployment instructions for **EcoSteps – Animated Recycling Guide**.

---

## 1. Prerequisites & Toolchain Setup

### System Requirements
| Component | Minimum Version | Recommended |
|---|---|---|
| **OS** | Windows 10/11, macOS 12+, Ubuntu 20.04+ | Windows 11 (x64 / ARM64), macOS Sonoma |
| **Flutter SDK** | 3.19.0+ (stable channel) | 3.29.0+ / latest stable |
| **Dart SDK** | 3.3.0+ | 3.9.0+ (included with Flutter) |
| **Git** | 2.30+ | 2.50+ |
| **Web Browser** | Chrome 110+, Edge, Firefox, Safari | Google Chrome / Chromium |
| **Java (Android)** | OpenJDK 17 | OpenJDK 17 (Zulu / Temurin) |

### Installing Flutter SDK
#### Windows
1. Download Flutter SDK from [flutter.dev/docs/get-started/install/windows](https://docs.flutter.dev/get-started/install/windows) or clone via Git:
   ```powershell
   git clone -b stable https://github.com/flutter/flutter.git C:\flutter
   ```
2. Add `C:\flutter\bin` to your environment `PATH`:
   ```powershell
   [System.Environment]::SetEnvironmentVariable("PATH", "C:\flutter\bin;" + [System.Environment]::GetEnvironmentVariable("PATH", "User"), "User")
   ```
3. Verify installation:
   ```powershell
   flutter doctor -v
   ```

#### macOS / Linux
```bash
git clone -b stable https://github.com/flutter/flutter.git ~/flutter
export PATH="$HOME/flutter/bin:$PATH"
flutter doctor -v
```

---

## 2. Cloning & Local Execution

### Clone Repository
```bash
git clone https://github.com/Syamprasad1212/PrivacyPreservingchatbot.git
cd PrivacyPreservingchatbot
```

### Install Dependencies
```bash
flutter pub get
```

### Run Locally
Run on your connected desktop/browser device:
```bash
# Run on default connected device (e.g., Windows Desktop, Chrome, macOS)
flutter run

# Run explicitly in Google Chrome (Web)
flutter run -d chrome

# Run explicitly on Windows Desktop
flutter run -d windows
```

---

## 3. Code Validation & Automated Tests

Run the following checks before committing any modifications:

```bash
# 1. Check code formatting
dart format --output=none --set-exit-if-changed lib test

# Format code automatically if needed
dart format lib test

# 2. Run static analysis
flutter analyze

# 3. Execute all automated tests (Unit, Widget, Animation)
flutter test --reporter expanded
```

---

## 4. Platform-Specific Build Instructions

### A. Web Build (Production)
```bash
# Standard root deployment
flutter build web --release

# For GitHub Pages or subdirectory hosting:
flutter build web --release --base-href "/PrivacyPreservingchatbot/"
```
The output bundle will be generated in `build/web/`.

### B. Android APK Build
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### C. Android App Bundle (Play Store)
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### D. Windows Desktop Build
*Requires Visual Studio 2022 with "Desktop development with C++" workload.*
```bash
flutter build windows --release
```
Output: `build/windows/x64/runner/Release/` (or `build/windows/arm64/runner/Release/`)

### E. macOS Desktop Build
*Requires macOS host and Xcode 15+.*
```bash
flutter build macos --release
```

### F. iOS Build
*Requires macOS host, Xcode 15+, and CocoaPods.*
```bash
flutter build ios --release --no-codesign
```

### G. Linux Desktop Build
*Requires Linux host, clang, cmake, pkg-config, and GTK 3 development headers.*
```bash
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
flutter build linux --release
```

---

## 5. GitHub Pages Deployment

### Base Href Configuration
When serving Flutter web apps from a GitHub repository page (e.g. `https://<username>.github.io/<repo-name>/`), Flutter must resolve asset routes using the repository name prefix.
- Build with `--base-href "/PrivacyPreservingchatbot/"`.

### Automated GitHub Actions Deployment
EcoSteps includes a configured CI/CD workflow (`.github/workflows/flutter_ci.yml`):
1. Navigate to **Settings > Pages** in your GitHub repository.
2. Under **Build and deployment > Source**, select **GitHub Actions**.
3. Push to `main` branch: GitHub Actions will automatically analyze the code, execute all unit and widget tests, build the web release with the correct base-href, and deploy to GitHub Pages.

---

## 6. Known Platform Limitations & Troubleshooting

1. **Windows ARM64 Platform Toolchain**:
   - Building native C++ Windows desktop executables (`flutter build windows`) on Windows 11 ARM64 requires the Visual Studio ARM64 C++ build tools installed via the Visual Studio Installer.
   - Flutter Web (`flutter build web`) and tests (`flutter test`) run universally across all architectures without native C++ compiler prerequisites.
2. **Reduced Motion Accessibility**:
   - On devices with system-level "Reduce Motion" enabled (`MediaQuery.disableAnimations == true`), EcoSteps automatically replaces slide/fade animations with instant layout reveals to prevent vestibular discomfort.
   - Users can also toggle animations manually in **Settings > Accessibility & Motion**.
