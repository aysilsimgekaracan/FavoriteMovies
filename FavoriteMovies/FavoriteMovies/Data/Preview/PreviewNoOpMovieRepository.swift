//
//  PreviewNoOpMovieRepository.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 16.01.2026.
//

import Foundation

/// A preview-only repository that does nothing.
/// Used to satisfy dependencies in SwiftUI previews.
final class NoOpMovieRepository: MovieRepositoryProtocol {
  
  func getMovies() async throws -> [Movie] { [] }

  func addMovie(
    title: String,
    description: String,
    rating: Int,
    genres: [String],
    releaseDate: Date
  ) async throws -> Movie {
    Movie(
      id: UUID(),
      title: title,
      description: description,
      rating: rating,
      posterURL: nil,
      genres: genres,
      releaseDate: releaseDate
    )
  }

  func uploadPoster(movieID: UUID, jpegData: Data) async throws -> Movie {
    Movie(
      id: movieID,
      title: "",
      description: "",
      rating: 0,
      posterURL: nil,
      genres: [],
      releaseDate: Date()
    )
  }

  func deleteMovie(_ movieID: UUID) async throws {
    // Intentionally no-op.
  }
}
