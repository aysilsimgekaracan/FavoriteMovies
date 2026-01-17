//
//  MovieRepositoryProtocol.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 24.12.2025.
//

import Foundation

protocol MovieRepositoryProtocol {
  func getMovies() async throws -> [Movie]

  func addMovie(title: String,
                   description: String,
                   rating: Int,
                   genres: [String],
                   releaseDate: Date) async throws -> Movie

  func uploadPoster(movieID: UUID, jpegData: Data) async throws -> Movie

  func deleteMovie(_ movieID: UUID) async throws
}
