//
//  MoviesView.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 24.12.2025.
//

import SwiftUI

struct MoviesView: View {
  @StateObject var viewModel: MoviesViewModel

  var body: some View {
    VStack {
      Text("Movies")
        .font(.largeTitle)
        .padding()
        .fontWeight(.bold)

      List(viewModel.movies) { movie in
        VStack(spacing: 12) {
          Text(movie.title)
            .font(.title)

          Text(movie.description)

          Text(movie.releaseDate.ISO8601Format())
          
          Text(movie.genres.joined(separator: ", "))

          HStack(spacing: 0) {
            Text(String(repeating: "★", count: movie.rating))
            Text(String(repeating: "☆", count: 10 - movie.rating))
          }
        }
      }
      .task {
        await viewModel.loadMovies()
      }
    }
  }
}

#Preview {
    MoviesView(viewModel: MoviesViewModel(
        useCase: GetMoviesUseCase(
            repository: MovieRepository()
        )
    ))
}
