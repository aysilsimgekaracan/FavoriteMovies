//
//  MovieRepositoryProtocol.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 24.12.2025.
//

protocol MovieRepositoryProtocol {
  func getMovies() async throws -> [Movie]

  func addMovie(_ movie: Movie) async throws

  func deleteMovie(_ movie: Movie) async throws
}
