//
//  MoviesViewModel.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 24.12.2025.
//

import Combine
import SwiftUI

@MainActor
class MoviesViewModel: ObservableObject {
  @Published var movies: [Movie] = []

  private let useCase: GetMoviesUseCase

  init(useCase: GetMoviesUseCase) {
    self.useCase = useCase
  }

  func loadMovies() async {
    do {
      movies = try await useCase.execute()
    } catch {
      print("Error: \(error)")
    }
  }
}
