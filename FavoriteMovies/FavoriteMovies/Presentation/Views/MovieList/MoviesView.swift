//
//  MoviesView.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 24.12.2025.
//

import SwiftUI

struct MoviesView: View {
  @StateObject var viewModel: MoviesViewModel
  let addMovieViewModelFactory: () -> AddMovieViewModel
  let movieDetailViewModelFactory: (Movie) -> MovieDetailViewModel

  @State private var showAddMovie = false

  var body: some View {

    List(viewModel.movies) { movie in
      NavigationLink(value: movie) {
        MovieRow(movie: movie)
          .frame(maxWidth: .infinity)
      }
      .listRowBackground(Color.clear)
    }
    .scrollContentBackground(.hidden)
    .task {
      await viewModel.loadMovies()
    }
    .toolbar {
      Button {
        showAddMovie = true
      } label: {
        Image(systemName: "plus")
      }
    }
    .navigationTitle("Movies")
    .background(Color.background.ignoresSafeArea(.all))
    .navigationDestination(isPresented: $showAddMovie) {
      AddMovieView(
        viewModel: addMovieViewModelFactory()
      )
    }
    .navigationDestination(for: Movie.self) { movie in
      MovieDetailView(viewModel: movieDetailViewModelFactory(movie))
        .background(Color.background.ignoresSafeArea(.all))
    }
  }
}
