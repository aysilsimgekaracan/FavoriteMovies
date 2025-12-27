import Fluent

struct AddMovie: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("movies")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("rating", .int, .required)
            .field("poster_url", .string)
            .field("genres", .array(of: .string), .required)
            .field("release_date", .date, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("movies").delete()
    }
}