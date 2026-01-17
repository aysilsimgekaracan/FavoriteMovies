# FavoriteMovies

A full-stack iOS application for managing your favorite movies, built with **SwiftUI** (Clean Architecture) and backed by a **Server-side Swift (Vapor)** API with PostgreSQL.

## 📱 Screenshots

| Movie List | Movie Details | Add Movie |
|:---:|:---:|:---:|
| <img src="img/Simulator Screenshot - iPhone 16e - 2026-01-17 at 15.19.35.png" width="250"> | <img src="img/Simulator Screenshot - iPhone 16e - 2026-01-17 at 15.19.46.png" width="250"> | <img src="img/Simulator Screenshot - iPhone 16e - 2026-01-17 at 15.19.55.png" width="250"> |

## 🏗 Architecture

### 1. iOS Client (`FavoriteMovies/`)
Built using **Clean Architecture** principals to ensure testability and separation of concerns.
- **Presentation Layer**: SwiftUI Views & ViewModels.
- **Domain Layer**: Entities (`Movie`) and Use Cases (`GetMovies`, `AddMovie`, `DeleteMovie`).
- **Data Layer**: Repositories and Data Sources (API networking).
- **Dependency Injection**: Decoupled dependencies for easier testing.

### 2. Backend API (`FavoriteMoviesAPI/`)
A scalable REST API built with **Vapor** and **PostgreSQL**.
- **CRUD Operations**: Complete management of movie records.
- **Dockerized Database**: Easy setup using Docker Compose.
- **Swift 6 Ready**: Modern concurrency handling.

## ✨ Key Features

- **Browse Movies**: View a list of all your saved movies.
- **Detailed View**: See descriptions, ratings, and release dates.
- **Add New Movies**: Simple form to create new entries.
- **Delete Movies**: Remove movies you no longer want to track.

## 🚀 Getting Started

### Prerequisites
- **Xcode**
- **Docker** (For the database)
- **Swift Toolchain**

### Backend Setup
1. Navigate to the API directory:
   ```bash
   cd FavoriteMoviesAPI
   ```
2. Start the PostgreSQL database:
   ```bash
   docker compose up db -d
   ```
3. Run migrations to create the database tables:
   ```bash
   swift run FavoritesMovieAPI migrate --yes
   ```
4. Start the server:
   ```bash
   swift run
   ```
   The API will be running at `http://localhost:8080`.

### iOS App Setup
1. Open the project in Xcode:
   ```bash
   open FavoriteMovies/FavoriteMovies.xcodeproj
   ```
2. Ensure the Backend is running locally.
3. Select your simulator (e.g., iPhone 16).
4. Build and Run (**Cmd + R**).

## 📂 Directory Structure

```
FavoriteMovies/
├── FavoriteMovies/       # iOS Client Source Code
│   ├── Domain/           # Entities & Use Cases
│   ├── Data/             # Repositories & Networking
│   └── Presentation/     # SwiftUI Views
├── FavoriteMoviesAPI/    # Vapor Backend Source Code
│   ├── Sources/          # API Controllers & Models
│   └── docker-compose.yml
└── img/                  # Screenshots & Assets
```