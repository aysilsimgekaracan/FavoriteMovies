//
//  ContentView.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 23.12.2025.
//

import SwiftUI

struct ContentView: View {

  private let repository = MovieRepository()
  let container: AppContainer

  var body: some View {
    NavigationStack {
      MoviesView(
        viewModel: container.makeMoviesViewModel(),
        addMovieViewModelFactory: container.makeAddMovieViewModel
      )
    }
  }
}
