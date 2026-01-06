//
//  MovieDTO.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 3.01.2026.
//

import Foundation

struct MovieDTO: Decodable {
  let id: UUID
  let title: String
  let description: String
  let rating: Int
  let posterURL: URL?
  let genres: [String]
  let releaseDate: Date
}

extension MovieDTO {
  func toDomain() -> Movie {
    Movie(
      id: id,
      title: title,
      description: description,
      rating: rating,
      posterURL: posterURL,
      genres: genres,
      releaseDate: releaseDate
    )
  }
}
