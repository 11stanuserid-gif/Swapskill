# 🔄 SwapSkill — Flutter App

> **Skill Exchange. No Money. Just Value.**

Production-ready Flutter mobile application for SwapSkill — India's first non-monetary skill barter platform.

## ✨ Features

- 📱 **Phone OTP Authentication** with Firebase
- 🎯 **Smart Match Engine** — finds perfect skill partners
- 💬 **Real-time Chat** with voice notes and read receipts
- 📅 **Session Booking** with calendar
- 📹 **Video Calls** powered by Agora SDK
- ⭐ **Trust Score** + 5-star rating system
- 🎬 **30-second Intro Videos**
- 🏅 **Gamification** — badges, streaks, leaderboard
- 🌐 **Multi-language** — Hinglish + 9 regional languages
- 🌓 **Dark Mode** support
- ✨ **Premium Neumorphic UI** — soft 3D buttons

## 🛠️ Tech Stack

| Component | Tech |
|---|---|
| Framework | Flutter 3.10+ |
| State | Provider + Bloc |
| Networking | Dio + Retrofit |
| Real-time | Socket.IO |
| Auth | Firebase OTP |
| Video | Agora RTC SDK |
| Storage | Hive + Secure Storage |
| UI | Custom Neumorphic + Google Fonts |

## 🚀 Setup

```bash
# 1. Get Flutter packages
flutter pub get

# 2. Run on Android emulator
flutter run

# 3. Build release APK
flutter build apk --release

# 4. Build release iOS
flutter build ios --release --no-codesign
```

## ⚙️ Configuration

Edit `lib/config/app_config.dart`:
- Set `baseUrl` to your production API
- Set `agoraAppId` to your Agora App ID
- Adjust `isDevelopment` flag

## 📦 Codemagic CI/CD

The repository includes a `codemagic.yaml` file with two workflows:
- **android-workflow**: Builds APK + AAB
- **ios-workflow**: Builds iOS app

To use:
1. Push code to GitHub
2. Connect repo to Codemagic
3. Workflows trigger automatically

## 🎨 Design System

**Theme**: Premium **Neumorphism** — soft 3D buttons that look pressed/raised.

**Color Palette**:
- Primary: `#6C5CE7` (Vibrant Purple)
- Secondary: `#FF6B9D` (Pink)
- Accent: `#00D9A3` (Mint Green)
- Highlight: `#FFB627` (Golden)

## 📁 Project Structure

```
lib/
├── config/           # App config + constants
├── core/
│   ├── theme/        # Colors + Neu theme
│   └── widgets/      # NeuButton, NeuCard, etc
├── data/
│   ├── models/       # Data models
│   └── providers/    # State providers
├── presentation/
│   └── screens/      # All UI screens
├── routes/           # App routing
├── services/         # API, Storage, Socket
└── main.dart
```

## 📄 License

MIT © SwapSkill Team
