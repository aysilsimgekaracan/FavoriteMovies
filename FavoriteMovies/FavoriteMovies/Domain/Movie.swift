//
//  Movie.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 23.12.2025.
//

import Foundation

struct Movie: Identifiable, Hashable {
  let id: UUID
  let title: String
  let description: String
  let rating: Int
  let posterURL: URL?
  let genres: [String]
  let releaseDate: Date
}
