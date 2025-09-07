# Notes App - Client

A Flutter-based note-taking application with offline-first architecture, cloud synchronization, and AI-powered content enhancement.

## Features

### Core Functionality
- **Note Management**: Create, edit, delete, and view notes with automatic timestamping
- **Google Authentication**: Secure sign-in with Google accounts
- **Offline-First Architecture**: Full functionality without internet connection(except AI enhancement)
- **Real-time Synchronization**: Automatic sync when connectivity is restored
- **AI Enhancement**: Improve note content using AI-powered suggestions
- **Smart Queue System**: Optimized offline operations queue with conflict resolution

### Technical Features
- **Repository Pattern**: Clean architecture with separation of concerns
- **Hive Local Storage**: Fast local database for offline data persistence
- **Provider State Management**: Reactive state management with ChangeNotifier
- **Connectivity Awareness**: Real-time network status monitoring
- **Queue Optimization**: Smart merging of offline operations before sync

## 🏗️ Architecture

### Clean Architecture Layers

```
lib/
├── domain/           # Business logic and entities
│   ├── entities/     # Core data models
│   └── repositories/ # Abstract repository interfaces
├── data/             # Data layer implementation
│   ├── datasources/  # Local and remote data sources
│   ├── models/       # Data transfer objects
│   ├── network/      # API clients and network models
│   ├── repositories/ # Repository implementations
│   └── services/     # Business services (sync orchestrator)
├── ui/               # Presentation layer
│   ├── screens/      # Screen widgets and view models
│   └── common/       # Reusable UI components
└── core/             # Core utilities and configuration
    ├── cache/        # Caching abstractions
    ├── connectivity/ # Network connectivity service
    ├── errors/       # Error definitions
    ├── network/      # Network configuration
    ├── router/       # App routing
    ├── theme/        # UI theme configuration
    └── utils/        # Utility classes
```

### Key Components

**Sync Orchestrator**: Manages offline-online synchronization with intelligent queue optimization
- Sync's with database whenever user's authentication state or connectivity state changes(both must be true)
- Handles operations on Queue(CRUD operations done while app is offline)
- Merges redundant operations (create+delete = no-op)
- Holds a lastSyncDate(key to incremental sync), to send to backend. lastSyncDate differs from client to client.
- Handles deleted notes(if deleted from a different device)

**Repository Pattern**: Abstracts data access with unified interface
- Switches between local and remote data sources
- Handles offline queueing automatically
- Provides Result type for error handling

## 🛠️ Technology Stack

### Authentication & Backend
- **Firebase Auth**: Google authentication
- **Firebase Core**: Firebase SDK integration
- **Custom Flask API**: Firebase storage access. Could be found on: https://github.com/ozanzadeoglu/notes-app-backend

### Data Persistence
- **Hive**: Fast, lightweight local database
- **Freezed**: Immutable data classes with code generation

### State Management & Navigation
- **Provider**: State management solution
- **Go Router**: Declarative routing

### Networking & Connectivity
- **Dio**: HTTP client for API calls
- **Connectivity Plus**: Network status monitoring

## 📱 How It Works

### Offline-First Architecture
1. **Local-First Operations**: All CRUD operations work locally first
2. **Queue System**: Failed network operations are queued for later sync
3. **Smart Sync**: When online, queued operations are optimized and synchronized
4. **Conflict Resolution**: Intelligent merging of offline operations

### Data Flow
```
User Action → ViewModel → Repository → Local Storage
                                     → Queue (if offline)
                                     → Remote API (if online)
```

### AI Enhancement Feature
1. User selects "Enhance" option in note view
2. System sends note UUID to backend AI service
3. Backend processes note content with AI
4. Enhanced content is returned and updated locally
5. User sees improved note content with success feedback
6. If operation takes too long an request gets timed out by dio, returns a custom error message that tells user to sync in a minute.

### Sync Optimization
- **Create + Delete**: Operations cancel each other (no server calls)
- **Create + Updates**: Single create with final content
- **Multiple Updates**: Only latest update is synchronized
- **Network-Aware**: Automatic sync when connectivity returns

## 🚦 Getting Started


### Firebase Setup
You'll need to create your own Firebase project and add the configuration files:

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Enable Google Authentication
3. Generate configuration files:
   - `firebase_options.dart` (generated via FlutterFire CLI)
   - `android/app/google-services.json` (Android)
   - `ios/Runner/GoogleService-Info.plist` (iOS)

**Note**: These files are in `.gitignore` for security reasons.

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd connectinno_case_client
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate required files**
   ```bash
   dart run build_runner build
   ```

4. **Configure Firebase**
   ```bash
   # Install FlutterFire CLI
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   
   # Configure Firebase for your project
   flutterfire configure
   ```

5. **Add Firebase configuration files** (not included in repo)
   - Place `google-services.json` in `android/app/`
   - Place `GoogleService-Info.plist` in `ios/Runner/`
   - Ensure `firebase_options.dart` is generated in `lib/`

7. **Get the backend**
   - Get backend from: https://github.com/ozanzadeoglu/notes-app-backend

6. **Run the application**
   ```bash
   flutter run
   ```



