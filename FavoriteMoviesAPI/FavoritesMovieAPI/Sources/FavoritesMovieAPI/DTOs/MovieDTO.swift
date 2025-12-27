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
}
