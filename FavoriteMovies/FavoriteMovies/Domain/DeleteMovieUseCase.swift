//
//  DeleteMovieUseCase.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 25.12.2025.
//

class DeleteMovieUseCase {
  private let repository: MovieRepositoryProtocol

  init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }

  func execute(movie: Movie) async throws {
    try await repository.deleteMovie(movie)
  }
}
