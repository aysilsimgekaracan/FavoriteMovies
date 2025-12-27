import Fluent
import struct Foundation.UUID
import Foundation

final class Movie: Model, @unchecked Sendable {
    static let schema = "movies"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String

    @Field(key: "rating")
    var rating: Int

    @Field(key: "poster_url")
    var posterURL: URL?

    @Field(key: "genres")
    var genres: [String]

    @Field(key: "release_date")
    var releaseDate: Date

    init() { }

    init(id: UUID? = nil,
         title: String,
         description: String,
         rating: Int,
         posterURL: URL?,
         genres: [String],
         releaseDate: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.rating = rating
        self.posterURL = posterURL
        self.genres = genres
        self.releaseDate = releaseDate
    }

    func toDTO() -> MovieDTO {
        .init(
            id: self.id,
            title: self.title,
            description: self.description,
            rating: self.rating,
            posterURL: self.posterURL,
            genres: self.genres,
            releaseDate: self.releaseDate
        )
    }
}
