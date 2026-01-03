import Fluent
import Vapor

struct MovieController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let movies = routes.grouped("movies")

        movies.get(use: self.index)
        movies.post(use: self.create)
        movies.group(":movieID") { movie in
            movie.delete(use: self.delete)
            movie.on(.POST, "poster", body: .collect(maxSize: "10mb"), use: self.uploadPoster)
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

    @Sendable
    func uploadPoster(req: Request) async throws -> MovieDTO {
        guard let id = req.parameters.get("movieID", as: UUID.self),
              let movie = try await req.movies.find(id: id) else {
            throw Abort(.notFound)
        }

        struct UploadInput: Content {
            var file: File
        }
        let input = try req.content.decode(UploadInput.self)
        
        let filename = "\(id.uuidString).jpg"
        let publicPath = req.application.directory.publicDirectory
        let uploadPath = publicPath + "uploads/" + filename

        try await req.fileio.writeFile(input.file.data, at: uploadPath)

        movie.posterURL = URL(string: "http://localhost:8080/uploads/\(filename)")
        try await req.movies.update(movie)

        return movie.toDTO()
    }
}