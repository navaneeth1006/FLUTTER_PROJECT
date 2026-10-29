#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status
set -e

FLUTTER_CHANNEL="stable"
FLUTTER_DIR="$HOME/flutter"

echo "========================================="
echo "  EcoSteps Render Deployment Build Script"
echo "========================================="

# 1. Download/Cache Flutter SDK
if [ ! -d "$FLUTTER_DIR/bin" ]; then
  echo ">>> Downloading Flutter SDK ($FLUTTER_CHANNEL branch)..."
  git clone https://github.com/flutter/flutter.git -b "$FLUTTER_CHANNEL" --depth 1 "$FLUTTER_DIR"
else
  echo ">>> Existing Flutter SDK found in cache."
fi

# 2. Add Flutter to PATH
export PATH="$FLUTTER_DIR/bin:$PATH"

# 3. Output environment info
echo ">>> Flutter Version:"
flutter --version

# 4. Enable Web and Precache artifacts
echo ">>> Enabling Flutter Web and precaching web artifacts..."
flutter config --enable-web
flutter precache --web

# 5. Fetch dependencies
echo ">>> Fetching dependencies (flutter pub get)..."
flutter pub get

# 6. Build Web release
echo ">>> Compiling Flutter Web for Production..."
flutter build web --release

echo "========================================="
echo "  Build Completed Successfully!"
echo "  Target Output: ./build/web"
echo "========================================="
