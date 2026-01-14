//
//  CreateMovieRequestDTO.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 14.01.2026.
//

import Foundation

struct CreateMovieRequestDTO: Encodable {
  let title: String
  let description: String
  let rating: Int
  let genres: [String]
  let releaseDate: Date
}

