import Vapor
import Fluent

struct PostgresMovieRepository: MovieRepository {
    let db: Database

    func create(_ movie: Movie) async throws {
        try await movie.save(on: db)
    }

    func all() async throws -> [Movie] {
        try await Movie.query(on: db).all()
    }

    func find(id: UUID) async throws -> Movie? {
        try await Movie.find(id, on: db)
    }

    func delete(id: UUID) async throws {
        try await Movie.query(on: db)
            .filter(\.$id == id)
            .delete()
    }
}
