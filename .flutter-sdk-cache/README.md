# Flutter SDK Pre-cached Artifacts

This folder contains pre-cached Flutter SDK artifacts for faster CI builds and Codemagic compatibility.

When the project is opened, these are auto-linked to the local Flutter installation. Codemagic uses these to skip dependency download.

**Contents:**
- `artifacts/` — Flutter engine binaries (Android/iOS/Web)
- Auto-generated when project initializes

**Note:** If you have a local Flutter SDK, run `flutter pub get` and these will be replaced/updated.
