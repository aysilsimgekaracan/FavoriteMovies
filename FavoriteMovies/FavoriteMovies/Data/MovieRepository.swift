//
//  MovieRepository.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 24.12.2025.
//

import Foundation

class MovieRepository: MovieRepositoryProtocol {
  private var movies: [Movie] = [
      Movie(
          id: UUID(),
          title: "The Shawshank Redemption",
          description: "Two imprisoned men bond over a number of years",
          rating: 3,
          posterURL: URL(string: "https://picsum.dev/400/600"),
          genres: ["Drama"],
          releaseDate: Date(timeIntervalSince1970: 757382400) // 1994
      ),
      Movie(
          id: UUID(),
          title: "The Dark Knight",
          description: "Batman faces the Joker in Gotham City",
          rating: 4,
          posterURL: URL(string: "https://picsum.dev/400/600"),
          genres: ["Action", "Crime"],
          releaseDate: Date(timeIntervalSince1970: 1216339200) // 2008
      ),
      Movie(
          id: UUID(),
          title: "Inception",
          description: "A thief who enters dreams to steal secrets",
          rating: 5,
          posterURL: nil,
          genres: ["Sci-Fi", "Thriller"],
          releaseDate: Date(timeIntervalSince1970: 1279065600) // 2010
      )
  ]

  func getMovies() async throws -> [Movie] {
    return movies
  }
  
  func addMovie(_ movie: Movie) async throws {
    movies.append(movie)
  }
  
  func deleteMovie(_ movie: Movie) async throws {
    movies.removeAll(where: { $0.id == movie.id })
  }
}
