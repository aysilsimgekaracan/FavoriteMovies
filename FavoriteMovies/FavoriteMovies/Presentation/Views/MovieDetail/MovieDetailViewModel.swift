//
//  MovieDetailViewModel.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 16.01.2026.
//

import Combine

@MainActor
class MovieDetailViewModel: ObservableObject {
  // MARK: Published Properties

  @Published var movie: Movie

  // MARK: Dependencies

  private let deleteMovieUseCase: DeleteMovieUseCase

  // MARK: Initialization

  init(movie: Movie, deleteMovieUseCase: DeleteMovieUseCase) {
    self.movie = movie
    self.deleteMovieUseCase = deleteMovieUseCase
  }
}
