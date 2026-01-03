import Fluent
import Vapor
import Foundation

struct MovieDTO: Content {
    var id: UUID?
    var title: String
    var description: String
    var rating: Int
    var posterURL: URL?
    var genres: [String]
    var releaseDate: Date

    func toModel() -> Movie {
        let model = Movie()
        
        model.id = self.id
        model.title = self.title
        model.description = self.description
        model.rating = self.rating
        model.posterURL = self.posterURL
        model.genres = self.genres
        model.releaseDate = self.releaseDate
        
        return model
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, rating, posterURL, genres, releaseDate
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(rating, forKey: .rating)
        try container.encode(posterURL, forKey: .posterURL)
        try container.encode(genres, forKey: .genres)
        try container.encode(releaseDate, forKey: .releaseDate)
    }
}
