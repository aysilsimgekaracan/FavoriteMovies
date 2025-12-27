import Vapor

extension Request {
    var movies: MovieRepository {
        PostgresMovieRepository(db: self.db)
    }
}
