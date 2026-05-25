# 🎵 Spotify Clone — SwiftUI

> A music app inspired by Spotify's UI/UX, built entirely with SwiftUI to showcase modern declarative UI development, reactive state management, and audio playback on iOS.

![Swift](https://img.shields.io/badge/Swift-5.9-orange?logo=swift)
![Platform](https://img.shields.io/badge/Platform-iOS%2016%2B-blue?logo=apple)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-purple)
![UI](https://img.shields.io/badge/UI-SwiftUI-cyan?logo=swift)
![No Dependencies](https://img.shields.io/badge/Dependencies-None-brightgreen)

---

## 📱 Overview

**Spotify Clone** is a fully native iOS application that replicates the core look and feel of Spotify. Built 100% with SwiftUI and no third-party dependencies, this project demonstrates proficiency in declarative UI design, MVVM architecture, local persistence, and AVFoundation-based audio playback.

---

## ✨ Features

- 🏠 Home screen with personalized content sections
- 🔍 Browse and search music catalog
- 🎵 Now Playing screen with playback controls
- 💿 Album and playlist detail views
- ❤️ Like and save songs using local persistence
- 🔊 Audio playback via AVFoundation
- 📱 Fully responsive layout with smooth animations
- 💾 Persistent favorites using UserDefaults / AppStorage

---

## 🏗️ Architecture

This project follows the **MVVM** (Model-View-ViewModel) pattern with SwiftUI's reactive data flow:

```
├── Views/          → SwiftUI screens and reusable components
├── ViewModels/     → ObservableObject classes with business logic
├── Models/         → Codable data structures (Entities)
├── Services/       → REST API layer and data fetching
├── Persistence/    → UserDefaults / AppStorage management
└── Resources/      → Assets, colors, fonts
```

State is managed through `@StateObject`, `@ObservedObject`, and `@EnvironmentObject`, following SwiftUI best practices.

---

## 🛠️ Tech Stack

| Category | Technologies |
|---|---|
| Language | Swift 5.9 |
| UI Framework | SwiftUI |
| Architecture | MVVM |
| State Management | @StateObject, @ObservedObject, @AppStorage |
| Networking | URLSession, REST APIs |
| Audio | AVFoundation |
| Persistence | UserDefaults, AppStorage |
| Animations | SwiftUI native animations & transitions |
| Tools | Xcode, Git, GitHub |
| Dependencies | None (pure Swift + Apple frameworks) |

---

## 📂 Project Structure

```
Spotify/
├── Core/
│   ├── Home/
│   │   ├── Views/
│   │   └── ViewModel/
│   ├── Search/
│   ├── Player/
│   │   ├── NowPlayingView
│   │   └── PlayerViewModel
│   └── Library/
├── Models/
├── Services/
│   └── APIService
├── Components/
│   ├── SongRowView
│   ├── AlbumCardView
│   └── PlayerControlsView
└── Resources/
```

---

## 🚀 Getting Started

### Requirements

- Xcode 15+
- iOS 16+
- No CocoaPods or SPM dependencies needed

### Installation

```bash
# Clone the repository
git clone https://github.com/adriancysvillegast/Spotify-SwiftUI.git

# Open the project
cd Spotify-SwiftUI
open Spotify.xcodeproj
```

Build and run directly — no additional setup required.

---

## 📸 Screenshots

> 📌 Add your screenshots here using the GitHub Issue trick:
> 1. Open a new Issue in this repo
> 2. Drag & drop your screenshots into the comment box
> 3. Copy the generated URLs and paste them below

<p align="center">
  <!-- Replace these placeholders with your actual screenshot URLs -->
  <img src="YOUR_SCREENSHOT_1_URL" width="220" alt="Home Screen" />
  &nbsp;&nbsp;
  <img src="YOUR_SCREENSHOT_2_URL" width="220" alt="Now Playing" />
  &nbsp;&nbsp;
  <img src="YOUR_SCREENSHOT_3_URL" width="220" alt="Search" />
</p>

---

## 💡 Key Technical Decisions

**Why no third-party dependencies?** This project was intentionally built using only Apple's native frameworks to demonstrate deep knowledge of the platform without relying on external libraries. Every feature — from networking to audio — uses first-party APIs.

**Why MVVM with SwiftUI?** MVVM maps naturally to SwiftUI's reactive model. ViewModels expose `@Published` properties that drive UI updates automatically, keeping views thin and logic testable.

**Why AppStorage for persistence?** For a music player prototype, lightweight key-value storage via `AppStorage` is the appropriate tradeoff. A production version would use CoreData or SwiftData for a larger music library.

---

## 👨‍💻 Author

**Adriancys Jesus Villegas Toro**
iOS Developer | Swift · UIKit · SwiftUI · RxSwift · MVVM · VIPER

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com/in/adriancys-jesus-villegas-toro-283641160/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?logo=github)](https://github.com/adriancysvillegast)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

> **Disclaimer:** This project is a UI/UX study inspired by Spotify. It is not affiliated with or endorsed by Spotify AB. All design inspiration is used for educational purposes only.
