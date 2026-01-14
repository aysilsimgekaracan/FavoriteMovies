//
//  AddMovieUseCase.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 25.12.2025.
//

import Foundation

class AddMovieUseCase {
  private let repository: MovieRepositoryProtocol

  init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }

  func execute(title: String,
               description: String,
               rating: Int,
               genres: [String],
               releaseDate: Date,
               posterJPEGData: Data?) async throws -> Movie {
    let created = try await repository.addMovie(title: title,
                                                   description: description,
                                                   rating: rating,
                                                   genres: genres,
                                                   releaseDate: releaseDate)
    guard let posterJPEGData else { return created }

    return try await repository.uploadPoster(movieID: created.id,
                                             jpegData: posterJPEGData)
  }
}
