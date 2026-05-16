# My Notes App

**AI-powered Flutter app combining notes and to-do features. Create, update, delete, and summarize notes with Vertex AI. To-do module (in progress) will support task management and AI-generated tasks. Built with Firebase and Sqflite for seamless sync and offline use.**

---

## Features

- **Smart Notes**
  - Add, update, delete, and categorize notes.
  - All notes are stored locally with Sqflite and can be synced via Firebase.
  - Notes can be summarized or enhanced using Vertex AI (Google).
- **To-Do List**
  - Simple task management: add, complete, and delete tasks.
  - Tasks organized and marked as priority or pending.
  - (Planned) AI-powered to-do task suggestions.
- **Cross-Platform**
  - Works on Android, iOS, Web, macOS, Windows, and Linux.
- **Modern UI/UX**
  - Custom fonts, color themes, cards and grids for organization.
  - Responsive and visually appealing layout.
- **Offline & Cloud Sync**
  - Sqflite handles offline data storage.
  - Firebase provides cloud backup and auto-sync.

---

## Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Firebase Project](https://firebase.google.com/)
- Dart SDK (compatible version, specified in `pubspec.yaml`)
- Vertex AI credentials (for AI-powered features)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Ankitmondal04/my_Notes_App.git
   cd my_Notes_App
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) in appropriate folders.
   - Configure `lib/firebase_options.dart` if necessary.

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## Project Structure

```
.
├── lib/
│   ├── main.dart               # App entry; sets up themes, Firebase, routes
│   ├── screens/                # All app UI screens
│   │   ├── home_screen.dart    # Main dashboard with notes grid & navigation
│   │   ├── login_screen.dart   # Login/auth screen
│   │   ├── splash_screen.dart  # Intro/splash
│   │   ├── textEditing_screen.dart # Note add/edit screen
│   │   └── todo_screen.dart    # Tasks/to-do interface
│   ├── data/
│   │   ├── database.dart       # Sqflite setup for notes/tasks
│   │   └── repositories/       # Data abstraction
│   │       ├── notesRepo.dart  # Handles CRUD for notes
│   │       └── todoRepo.dart   # Handles CRUD for tasks
│   └── stateManager/           
│       ├── generative_ai_services.dart # Vertex AI integration
│       └── notesManager.dart   # (Planned) app state orchestrator
├── assets/                     # Fonts and images for UI
├── android/ ios/ linux/ macos/ windows/ web/
├── pubspec.yaml                # App & dependency configuration
└── ...
```

---

## Major Dependencies

- `flutter`: Core framework for cross-platform development.
- `cupertino_icons`: iOS styled icons.
- `firebase_core`, `firebase_ai`: Firebase and Vertex AI/ML integration.
- `sqflite`: Local SQLite database for offline storage.
- `intl`: Date/Time formatting.
- Custom assets: Fonts (Tinos, Capriola, Bitcount, etc.)

---

## Application Walkthrough

### Notes Feature
- Home screen displays all notes as cards in a grid using `home_screen.dart`. 
- Notes are stored locally via `notesRepo.dart` (Sqflite) for offline use.
- Tap a note to view/edit (routes to `textEditing_screen.dart`), or add/delete notes via floating action button or card menu.
- Notes have title, content, timestamp.

### To-Do Feature
- Accessed via the tasks icon or main menu.
- `todo_screen.dart` uses `todoRepo.dart` for local task CRUD.
- Tasks displayed as a checklist (with chips for filtering: priority, today's, not completed, etc).
- Add/edit/delete tasks with dialogs.
- (Planned) AI-powered suggestions for tasks.

### AI & Cloud Sync
- Firebase handles cloud backup/auth.
- Vertex AI is integrated for automatic note summaries and smarter productivity (see `generative_ai_services.dart`).

---

## Customization

- **Fonts & Themes:** Edit `pubspec.yaml` under `fonts` and `assets`, change color and font settings in `main.dart`.
- **Data Models:** Expand repositories and database structure in `lib/data/`.
- **AI Features:** Integrate more Vertex AI functionality via the service layer.

---

## Contribution

Contributions welcome! Open issues or pull requests for new features, bugfixes, or enhancements.

---

## License

[MIT](LICENSE) (or specify your project's license file)

---

## Acknowledgements

- Built with [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Vertex AI](https://cloud.google.com/vertex-ai)
- Fonts from Google Fonts.
