//
//  RemoteMovieRepository.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 3.01.2026.
//

import Foundation

final class RemoteMovieRepository: MovieRepositoryProtocol {
  private let api: MoviesAPIClient

  init(api: MoviesAPIClient) {
    self.api = api
  }

  func getMovies() async throws -> [Movie] {
    let dtos = try await api.fetchMovies()
    return dtos.map { $0.toDomain() }
  }

  func addMovie(title: String,
                description: String,
                rating: Int,
                genres: [String],
                releaseDate: Date) async throws -> Movie {
    let request = CreateMovieRequestDTO(title: title,
                                        description: description,
                                        rating: rating,
                                        genres: genres,
                                        releaseDate: releaseDate)
    return try await api.createMovie(request).toDomain()
  }

  func uploadPoster(movieID: UUID, jpegData: Data) async throws -> Movie {
    try await api.uploadPoster(movieID: movieID, jpegData: jpegData).toDomain()
  }

  func deleteMovie(_ movieID: UUID) async throws {
    try await api.deleteMovie(id: movieID)
  }
}
