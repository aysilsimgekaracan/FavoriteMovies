//
//  AppContainer.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 3.01.2026.
//

final class AppContainer {
  let movieRepository: MovieRepositoryProtocol

  init(movieRepository: MovieRepositoryProtocol = MovieRepository()) {
    self.movieRepository = movieRepository
  }


  func makeMoviesViewModel() -> MoviesViewModel {
    MoviesViewModel(useCase: GetMoviesUseCase(repository: movieRepository))
  }

  func makeAddMovieViewModel() -> AddMovieViewModel {
    AddMovieViewModel(useCase: AddMovieUseCase(repository: movieRepository))
  }
}
