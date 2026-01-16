//
//  ContentView.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 23.12.2025.
//

import SwiftUI

struct ContentView: View {

  let container: AppContainer

  var body: some View {
    NavigationStack {
      MoviesView(
        viewModel: container.makeMoviesViewModel(),
        addMovieViewModelFactory: container.makeAddMovieViewModel,
        movieDetailViewModelFactory: container.makeMovieDetailViewModel
      )
    }
  }
}
