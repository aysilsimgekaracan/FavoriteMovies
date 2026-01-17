//
//  MovieDetailViewModel.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 16.01.2026.
//

import Combine
import Foundation

@MainActor
class MovieDetailViewModel: ObservableObject {
  // MARK: Published Properties

  @Published var movie: Movie
  @Published var isDeleting: Bool = false
  @Published var errorMessage: String?
  @Published var shouldDismiss: Bool = false

  // MARK: Dependencies

  private let deleteMovieUseCase: DeleteMovieUseCase

  // MARK: Initialization

  init(movie: Movie, deleteMovieUseCase: DeleteMovieUseCase) {
    self.movie = movie
    self.deleteMovieUseCase = deleteMovieUseCase
  }

  // MARK: Actions

  func deleteMovie() async {
    guard !isDeleting else { return }

    isDeleting = true
    errorMessage = nil

    do {
      try await deleteMovieUseCase.execute(movie: movie)
      shouldDismiss = true
    } catch {
      errorMessage = "Delete failed. \(error.localizedDescription)"
    }

    isDeleting = false
  }
}
