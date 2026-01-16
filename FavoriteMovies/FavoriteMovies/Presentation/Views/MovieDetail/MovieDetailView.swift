//
//  MovieDetailView.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 16.01.2026.
//

import SwiftUI

struct MovieDetailView: View {
  @StateObject var viewModel: MovieDetailViewModel
  @Environment(\.dismiss) var dismiss

  let columns = [
    GridItem(.adaptive(minimum: 100))
  ]

  var body: some View {
    ScrollView {
      VStack {
        // Image
        ZStack {
          AsyncImage(url: viewModel.movie.posterURL) { phase in
            switch phase {
            case .success(let image):
              image
                .resizable()

            case .failure:
              Rectangle()
                .fill(Color.black.opacity(0.3))
                .frame(width: 256, height: 384)

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
        }
        .padding()

        // Rating and Release Date
        HStack(spacing: 20) {
          // Rating
          HStack(spacing: 0) {
            Text(String(repeating: "★", count: viewModel.movie.rating))
            Text(String(repeating: "☆", count: 5 - viewModel.movie.rating))
          }
          .foregroundStyle(.yellow)

          Text("·")
            .foregroundStyle(.white)

          // Release Date
          Text(viewModel.movie.releaseDate.localizedDayMonthYear())
            .foregroundStyle(.white)
        }
        .padding()

        // Description
        Text(viewModel.movie.description)
          .foregroundStyle(.white)
          .padding()
          .background(Color.black.opacity(0.05))
          .cornerRadius(12)

        // Genres
        LazyVGrid(columns: columns) {
          ForEach(viewModel.movie.genres.sorted(), id: \.self) { genre in
            Text(genre)
              .foregroundStyle(Color.white)
              .padding(.horizontal, 12)
              .padding(.vertical, 6)
              .background(Color.black.opacity(0.8))
              .clipShape(Capsule())
          }
        }
      }
    }
    .toolbar {
      Button(role: .destructive) {
        dismiss()
      } label: {
        Image(systemName: "trash")
      }

    }
    .navigationTitle(viewModel.movie.title)
  }
}

#Preview {
  let movie = Movie(
    id: UUID(),
    title: "Inception",
    description: "Dream within a dream",
    rating: 5,
    posterURL: URL(string: "http://localhost:8080/uploads/B0972148-14AB-43C2-80CD-A9FBC4316529.jpg"),
    genres: ["Sci-Fi"],
    releaseDate: Date()
  )

  let repository = NoOpMovieRepository()
  let deleteUseCase = DeleteMovieUseCase(repository: repository)

  return NavigationStack {
    ZStack {
      Color.background.ignoresSafeArea()
      MovieDetailView(
        viewModel: MovieDetailViewModel(
          movie: movie,
          deleteMovieUseCase: deleteUseCase
        )
      )
    }
  }
}
