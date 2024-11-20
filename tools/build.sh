#!/bin/bash
ios_directory="../ios"
flutter_directory=".."
publish_dir="../publish"

# Calculate absolute paths
absolute_flutter_directory=$(realpath "$flutter_directory")
absolute_ios_directory=$(realpath "$ios_directory")
absolute_publish_dir=$(realpath "$publish_dir")

echo "Absolute Flutter directory: $absolute_flutter_directory"
echo "Absolute IOS directory: $absolute_ios_directory"
echo "Absolute Publish directory: $absolute_publish_dir"

# Extract app name and version number
app_name=$(cat "$absolute_flutter_directory/pubspec.yaml" | awk '/name:/ {print $2}')
version_number=$(cat "$absolute_flutter_directory/pubspec.yaml" | awk '/version:/ {print $2}')

function inc_buildnumber {
  echo "App Name: $app_name"
  echo "Version number (OLD): $version_number"
  echo "Increasing build number..."
  set -e
  perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.($2+1)/e' "$absolute_flutter_directory/pubspec.yaml"
  echo "Build number increased"
  version_number=$(cat "$absolute_flutter_directory/pubspec.yaml" | awk '/version:/ {print $2}')
  echo "Version number (NEW): $version_number"
}

function ios_clean {
  echo "Clean and install pod for IOS $absolute_ios_directory"
  echo "[Start]"
  rm "$absolute_ios_directory/Podfile.lock"
  cd "$absolute_flutter_directory"
  flutter clean
  flutter pub get
  cd "$absolute_ios_directory"
  pod repo update
  pod install
  echo "[Done]"
}

function prod_ios {
  echo "Build for ios $version_number"
  echo "[Start]"
  cd "$absolute_flutter_directory"
  flutter clean
  flutter pub get
  cd "$absolute_ios_directory"
  pod repo update
  pod install
  flutter packages pub run build_runner build --delete-conflicting-outputs
  flutter build ipa --flavor prod -t lib/main_production.dart
  mkdir -p "$absolute_publish_dir/$version_number/ipa"
  cp "$absolute_flutter_directory/build/app/outputs/flutter-apk/app-prod-release.ipa" \
    "$absolute_publish_dir/$version_number/ipa/$app_name-prod-release-$version_number.ipa"
  echo "[Done]"
}

function prod_apk {
  # Stage builds and copy APK
  echo "Building Android Production APK $version_number"
  echo "[Start]"

  cd "$absolute_flutter_directory"
  flutter clean
  flutter pub get
  flutter packages pub run build_runner build --delete-conflicting-outputs
  flutter build apk --flavor prod -t lib/main_production.dart --release

  mkdir -p "$absolute_publish_dir/$version_number/apk"
  cp "$absolute_flutter_directory/build/app/outputs/flutter-apk/app-prod-release.apk" \
    "$absolute_publish_dir/$version_number/apk/$app_name-prod-release-$version_number.apk"

  echo "[Done]"
}

function prod_appbundle {
  # Stage builds and copy APK
  echo "Building Android Production Appbundle $version_number"
  echo "[Start]"

  cd "$absolute_flutter_directory"
  flutter clean
  flutter pub get
  flutter packages pub run build_runner build --delete-conflicting-outputs
  flutter build appbundle --flavor prod -t lib/main_production.dart --release

  mkdir -p "$absolute_publish_dir/$version_number/appbundle"
  cp "$absolute_flutter_directory/build/app/outputs/bundle/prodRelease/app-prod-release.aab" \
    "$absolute_publish_dir/$version_number/appbundle/$app_name-prod-release-$version_number.aab"

  echo "[Done]"
}

function stag_apk {
  # Stage builds and copy APK
  echo "Building Android Stag APK $version_number"
  echo "[Start]"

  cd "$absolute_flutter_directory"
  flutter clean
  flutter pub get
  flutter packages pub run build_runner build --delete-conflicting-outputs
  flutter build apk --flavor stag -t lib/main.dart --release

  mkdir -p "$absolute_publish_dir/$version_number/apk"
  cp "$absolute_flutter_directory/build/app/outputs/flutter-apk/app-stag-release.apk" \
    "$absolute_publish_dir/$version_number/apk/$app_name-stag-release-$version_number.apk"

  echo "[Done]"
}

function dev_apk {
  # Dev builds and copy APK
  echo "Building Android Dev APK $version_number"
  echo "[Start]"

  cd "$absolute_flutter_directory"
  flutter clean
  flutter pub get
  flutter packages pub run build_runner build --delete-conflicting-outputs
  flutter build apk --flavor dev -t lib/main_development.dart --release

  mkdir -p "$absolute_publish_dir/$version_number/apk"
  cp "$absolute_flutter_directory/build/app/outputs/flutter-apk/app-dev-release.apk" \
    "$absolute_publish_dir/$version_number/apk/$app_name-dev-release-$version_number.apk"

  echo "[Done]"
}

function bais_dev_apk {
  # Dev builds and copy APK
  echo "Building Android Dev APK $version_number"
  echo "[Start]"

  cd "$absolute_flutter_directory"
  flutter clean
  flutter pub get
  flutter packages pub run build_runner build --delete-conflicting-outputs
  flutter build apk --flavor baisdev -t lib/main_development.dart --release

  mkdir -p "$absolute_publish_dir/$version_number/apk"
  cp "$absolute_flutter_directory/build/app/outputs/flutter-apk/app-baisdev-release.apk" \
    "$absolute_publish_dir/$version_number/apk/$app_name-bais-baisdev-release-$version_number.apk"

  echo "[Done]"
}

function android {
  echo "Building Android all flavors"
  dev_apk
  bais_dev_apk
  stag_apk
  prod_apk
  prod_appbundle
  echo "Android build all flavor done"
}

function android_inc {
  echo "Increase build number then building Android"
  inc_buildnumber
  android
  echo "Increase build number then building Android build done"
}

function all {
  echo "Building Android and IOS all"
  ios_clean
  prod_ios
  android
  echo "Android and IOS build done"
}

function all_inc() {
  echo "Increase build number then building Android and IOS "
  inc_buildnumber
  all
  echo "Increase build number then building Android and IOS  build done"
}

if [[ "$1" == "inc_buildnumber" ]]; then
  inc_buildnumber
elif [[ "$1" == "ios_clean" ]]; then
  ios_clean
elif [[ "$1" == "prod_ios" ]]; then
  prod_ios
elif [[ "$1" == "prod_appbundle" ]]; then
  prod_appbundle
elif [[ "$1" == "prod_apk" ]]; then
  prod_apk
elif [[ "$1" == "stag_apk" ]]; then
  stag_apk
elif [[ "$1" == "dev_apk" ]]; then
  dev_apk
elif [[ "$1" == "bais_dev_apk" ]]; then
  bais_dev_apk
elif [[ "$1" == "android" ]]; then
  android
elif [[ "$1" == "android_inc" ]]; then
  android_inc
elif [[ "$1" == "all" ]]; then
  all
elif [[ "$1" == "all_inc" ]]; then
  all_inc
else
  echo "Usage: $0 {inc_buildnumber|ios_clean|prod_ios|prod_appbundle|prod_apk|stag_apk|dev_apk|android|android_inc|all|all_inc}"
  exit 1
fi
