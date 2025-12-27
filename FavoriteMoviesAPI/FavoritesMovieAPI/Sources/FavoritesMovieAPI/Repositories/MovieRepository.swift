import Vapor
import Fluent

protocol MovieRepository: Sendable {
    func create(_ movie: Movie) async throws
    func all() async throws -> [Movie]
    func find(id: UUID) async throws -> Movie?
    func delete(id: UUID) async throws
}
