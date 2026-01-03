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

  @State private var showAddMovie = false

  var body: some View {

    List(viewModel.movies) { movie in
      VStack {
        ZStack {
          AsyncImage(url: movie.posterURL) { phase in
            switch phase {
            case .failure:
              Rectangle()
                .fill(Color.black.opacity(0.3))
                .frame(width: 256, height: 384)

            case .success(let image):
              image
                .resizable()
            default:
              ProgressView()
            }
          }
          .frame(width: 256, height: 384)
          .clipShape(.rect(cornerRadius: 25))

          LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0), Color.black.opacity(0.9)]),
                         startPoint: .top,
                         endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            .frame(width: 256, height: 384)
            .clipShape(.rect(cornerRadius: 25))

          VStack {
            Spacer()

            Text(movie.title)
              .font(.callout)
              .foregroundStyle(.white)

            HStack(spacing: 0) {
              Text(String(repeating: "★", count: movie.rating))
              Text(String(repeating: "☆", count: 5 - movie.rating))
            }
            .foregroundStyle(.yellow)
            .padding(.bottom, 12)
          }
        }
      }
      .frame(maxWidth: .infinity)
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
    .sheet(isPresented: $showAddMovie) {
        AddMovieView(
            viewModel: addMovieViewModelFactory()
        )
    }
  }
}

#Preview {
  let container = AppContainer(movieRepository: MovieRepository())

  NavigationStack {
    MoviesView(
      viewModel: container.makeMoviesViewModel(),
      addMovieViewModelFactory: { container.makeAddMovieViewModel() }
    )
  }
}
