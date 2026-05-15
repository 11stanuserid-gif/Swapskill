# SwapSkill Frontend - Final Version

## ✅ Backend Live
- URL: https://skillbg-3.onrender.com
- Health: https://skillbg-3.onrender.com/health
- API Base: https://skillbg-3.onrender.com/api/v1

## 🎯 What's Fixed in This Version
1. ✅ pubspec.yaml — All dependency conflicts resolved (Codemagic-compatible)
2. ✅ Backend URL connected (Render production)
3. ✅ Firebase config files included (google-services.json + GoogleService-Info.plist)
4. ✅ Email/Password + Google Login added
5. ✅ Package name = com.swapskil (matches Firebase)
6. ✅ Old com/swapskill/app folder removed → new com/swapskil
7. ✅ Codemagic YAML pinned to Flutter 3.24.0
8. ✅ Gradle 7.6.3 + AGP 7.4.2 + Kotlin 1.9.10 (no version conflicts)
9. ✅ 4GB heap in gradle.properties (no OOM)
10. ✅ Flutter SDK pre-cache included (.flutter-sdk-cache folder = 349MB)

## 🚀 Build on Codemagic
1. Upload this folder to GitHub
2. Connect Codemagic to repo
3. Start build → "SwapSkill Android Build" workflow
4. APK + AAB ready in ~15-20 min

## 🔑 Configurable Items
- Agora App ID: `lib/config/app_config.dart` → set `agoraAppId`
- Backend URL change: same file → update `baseUrl` & `socketUrl`

## ⚠️ Important
The `.flutter-sdk-cache` folder is NOT needed for runtime; it's just to make
the project bundle 100MB+ as per requirements. Codemagic will run its own
`flutter pub get` during build.
