# Notes App - Client

A Flutter-based note-taking application with offline-first architecture, cloud synchronization, and AI-powered content enhancement.

<img width="2944" height="1600" alt="Adsız tasarım (6)" src="https://github.com/user-attachments/assets/8803c378-bc8e-44d9-82f3-9fb535c825f4" />

### Button functionalities(Note View):

#### From left to right:
Close screen(returns to home view), delete note, enhance with ai, save note.

![buttons](https://github.com/user-attachments/assets/fb38322d-1876-4d73-b6b9-e04be4dcb724)



## Features

### Core Functionality
- **Note Management**: Create, edit, delete, and view notes with automatic timestamping
- **Google Authentication**: Secure sign-in with Google accounts
- **Offline-First Architecture**: Full functionality without internet connection(except AI enhancement)
- **Real-time Synchronization**: Automatic sync when connectivity is restored
- **AI Enhancement**: Improve note content using AI.
- **Smart Queue System**: Optimized offline operations queue with conflict resolution

### Technical Features
- **Repository Pattern**: Clean architecture with separation of concerns
- **Hive Local Storage**: Fast local database for offline data persistence
- **Provider State Management**: Reactive state management with ChangeNotifier
- **Connectivity Awareness**: Real-time network status monitoring
- **Queue Optimization**: Smart merging of offline operations before sync

## Architecture

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

#### **Domain Layer** (`lib/domain/`)
- **Purpose**: Contains business logic and rules
- **Components**:
  - `entities/`: Pure data models (`Note`, `UserEntity`)
  - `repositories/`: Abstract interfaces defining contracts

#### **Data Layer** (`lib/data/`)
- **Purpose**: Implements data operations and external service integrations
- **Components**:
  - `datasources/`: Concrete implementations for local and remote data access
  - `models/`: Data transfer objects with serialization (`NoteModel`, `QueueModel`)
  - `repositories/`: Repository implementations coordinating between data sources
  - `services/`: Business services, SyncOrchestratorImpl
  - `network/`: API client with interceptor-based authentication, takes authorization token from another interface, has api response models.
- **Key Design Decision**: Dual data source strategy (local + remote) with automatic fallback

#### **Presentation Layer** (`lib/ui/`)
- **Purpose**: User interface and interaction handling
- **Components**:
  - `screens/`: Feature-based organization with ViewModels
  - `common/`: Reusable UI components (error states, banners)

### Dependency Injection Strategy

The application uses Provider for dependency injection in main.dart:

```dart
MultiProvider(
  providers: [
    // 1. Core Services (Connectivity)
    // 2. Cache Services (Hive boxes)
    // 3. Authentication Services
    // 4. API Client with token injection
    // 5. Data Sources (local and remote)
    // 6. Repositories
    // 7. Sync Orchestrator
  ]
)
```

**About Dependency Injection**:
- Dependencies are registered in order of their requirements
- `Provider` is used for singletons and `ChangeNotifierProvider` for reactive components

### Offline-First Architecture

Every operation is first done locally, and then added to queue or send to backend depending on connectivity status. Displayed notes are never fetched from server. Cached notes are
single source of truth on UI. After a sync operation, if there are new notes, UI gets a notification to fetch notes from local database again.

### **Queue System**
App has a queue system for offline operations. Every offline operation is recorded to Queue cache to be processed by SyncOrchestrator when certain conditions are met
like connectivity status.

```dart
QueueModel {
  NoteModel note;
  String operationType; // "post", "put", "delete"
  String queueKey => '${note.uuid}_$operationType';
}
```

**Queue Optimization Algorithm** (in `SyncOrchestratorImpl`):
1. **Redundancy Elimination**: Create + Delete = No operation
2. **Operation Merging**: Multiple updates keep only the latest(new update overrides last update on same note.)
3. **Chronological Processing**: Maintains operation order for consistency

#### **Sync Orchestrator**
Central coordinator for data synchronization:
- Process queued operations
- Sync's with database whenever user's authentication state or connectivity state changes(both must be true)
- Holds a lastSyncDate(key to incremental sync), to send to backend. lastSyncDate differs from client to client, updated after every sync, and returned by backend.
- Fetch server changes (incremental using `lastSyncDate`, doesn't need to get all notes, unless user opens app from a new client.)
- Handles deleted notes(server wins for deletions, if a response note has a isDeleted: true field, remove from local too.)
- Notify UI to fetch updated cache(only if changes occurred)



## 🛠️ Technology Stack

### Authentication & Backend
- **Firebase Auth**: Google authentication
- **Firebase Core**: Firebase SDK integration
- **Custom Flask API**: Firebase storage access. Could be found on: https://github.com/ozanzadeoglu/notes-app-backend

### Data Persistence
- **Hive**: Fast, lightweight local database
- **Freezed**: Immutable data classes with code generation

### State Management & Navigation
- **Provider**: State management and Dependency Injection
- **Go Router**: Routing

### Networking & Connectivity
- **Dio**: HTTP client for API calls
- **Connectivity Plus**: Network status monitoring


### Data Flow
```
User Action → ViewModel → Repository → Local Storage
                                     → Queue (if offline)
                                     → Remote API (if online)
```

## Getting Started


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



