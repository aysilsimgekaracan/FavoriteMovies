import Fluent
import Vapor

struct MovieController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let movies = routes.grouped("movies")

        movies.get(use: self.index)
        movies.post(use: self.create)
        movies.group(":movieID") { movie in
            movie.delete(use: self.delete)
        }
    }

    @Sendable
    func index(req: Request) async throws -> [MovieDTO] {
        try await req.movies.all().map { $0.toDTO() }
    }

    @Sendable
    func create(req: Request) async throws -> MovieDTO {
        let movie = try req.content.decode(MovieDTO.self).toModel()
        try await req.movies.create(movie)
        return movie.toDTO()
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let id = req.parameters.get("movieID", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        // Check if exists first (optional, but good practice in repo pattern if delete doesn't throw notFound)
        guard try await req.movies.find(id: id) != nil else {
             throw Abort(.notFound)
        }

        try await req.movies.delete(id: id)
        return .noContent
    }
}