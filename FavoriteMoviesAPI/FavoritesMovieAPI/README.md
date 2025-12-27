# FavoritesMovieAPI

💧 Simple Movie API using Swift Vapor and PostgreSQL.

## Getting Started

To build the project using the Swift Package Manager, run the following command in the terminal from the root of the project:
```bash
swift build
```

To run the project and start the server, use the following command:
```bash
swift run
```

To execute tests, use the following command:
```bash
swift test
```

## How to Run
### Infrastructure
Ensure your Docker container is running (mapped to port 5433).

```docker compose up db -d```

### Prepare the Database (Migration)
Before running the app for the first time, you must create the tables:

```swift run FavoritesMovieAPI migrate --yes```

### Run the App
Open Package.swift in Xcode and hit Run. OR run in terminal: ```swift run```

### Test API
#### List Movies
```curl http://localhost:8080/movies```

#### Create Movie
```
curl -X POST http://localhost:8080/movies \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Inception",
    "description": "Dream within a dream",
    "rating": 5,
    "genres": ["Sci-Fi"],
    "releaseDate": "2010-07-16T00:00:00Z"
  }'
```

#### Delete Movie (Replace ID with one returned from Create or List)
```curl -X DELETE http://localhost:8080/movies/869B4D0A-13B3-4B3B-9B17-676EE2052246```

### See more

- [Vapor Website](https://vapor.codes)
- [Vapor Documentation](https://docs.vapor.codes)
- [Vapor GitHub](https://github.com/vapor)
- [Vapor Community](https://github.com/vapor-community)
