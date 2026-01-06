//
//  AppContainer.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 3.01.2026.
//

import Foundation

final class AppContainer {
  let movieRepository: MovieRepositoryProtocol

  init() {
    let baseURL = URL(string: "http://localhost:8080")!
    let api = MoviesAPIClient(baseURL: baseURL)

    self.movieRepository = RemoteMovieRepository(api: api)
  }


  func makeMoviesViewModel() -> MoviesViewModel {
    MoviesViewModel(useCase: GetMoviesUseCase(repository: movieRepository))
  }

  func makeAddMovieViewModel() -> AddMovieViewModel {
    AddMovieViewModel(useCase: AddMovieUseCase(repository: movieRepository))
  }
}
