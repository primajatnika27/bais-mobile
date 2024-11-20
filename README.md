# BAIS Mobile

# Comand for triger runner

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

# Config .vscode/launch.json

```
{
  "version": "0.2.0",
  "configurations": [
    {
        "name": "Flutter Dev",
        "type": "dart",
        "request": "launch",
        "flutterMode": "debug",
        "program": "lib/main_development.dart",
        "args": ["--flavor", "dev"]
    },
    {
        "name": "Flutter Stage",
        "type": "dart",
        "request": "launch",
        "flutterMode": "debug",
        "program": "lib/main.dart",
        "args": ["--flavor", "stag"]
    },
    {
        "name": "Flutter Prod",
        "type": "dart",
        "request": "launch",
        "flutterMode": "release",
        "program": "lib/main_production.dart"
    }
  ]
}
```

## Build Script Usage

Our project uses a build script `build.sh` for handling various operations. Below you will find a description for each
parameter.

To use the build script, navigate to the `/tools` directory and run the following command in your shell:

```bash
 ./build.sh [parameter]
```

Replace `[parameter]` with one of the options listed below:

- `inc_buildnumber`: for increasing the Flutter application's version number. It modifies the `pubspec.yaml` file.
- `ios_clean`: for cleaning and re-installing the iOS pods. It first removes the `Podfile.lock`, performs
  a `flutter clean` and `flutter pub get` command, up.sh
- `prod_ios`: for building the Flutter application for iOS in production mode.
- `prod_appbundle`: for building the Flutter application for Android with an output of the app bundle (.aab), meant for
  production use.
- `prod_apk`: for building the Flutter application for Android, creating an APK for production use.
- `stag_apk`: for building the Flutter application for Android, creating an APK for staging use.
- `dev_apk`: for building the Flutter application for Android, creating an APK for development use.
- `android`: to build all Android flavors such as development, staging and production applications, including a
  production app bundle.
- `android_inc`: for increasing build number and building all Android applications.
- `all`: for building iOS (production) and all Android applications.
- `all_inc`: for increasing the build number, and building iOS (production) and all Android applications.

Please note to replace `[parameter]` with the names provided above, like so:

```bash
./build.sh inc_buildnumber
```

This would increase the build number of your Flutter application, for instance. Adjust the parameters according to your
needs.

## Screen Copy

run on gitbash

```sh
% nohup scrcpy --always-on-top -b 12M --stay-awake &
```
