//
//  GetMoviesUseCase.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 24.12.2025.
//

class GetMoviesUseCase {
  private let repository: MovieRepositoryProtocol

  init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }

  func execute() async throws -> [Movie] {
    try await repository.getMovies()
  }
}

