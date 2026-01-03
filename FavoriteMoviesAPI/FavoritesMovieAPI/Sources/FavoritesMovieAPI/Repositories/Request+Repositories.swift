import Vapor

extension Request {
    var movies: any MovieRepository {
        PostgresMovieRepository(db: self.db)
    }
}
