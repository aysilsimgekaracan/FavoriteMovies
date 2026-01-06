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

  func addMovie(_ movie: Movie) async throws {
    fatalError("Not implemented yet")
  }

  func deleteMovie(_ movie: Movie) async throws {
    fatalError("Not implemented yet")
  }
}
