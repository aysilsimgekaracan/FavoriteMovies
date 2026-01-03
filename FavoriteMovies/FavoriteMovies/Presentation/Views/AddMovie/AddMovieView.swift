//
//  AddMovieView.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 29.12.2025.
//

import PhotosUI
import SwiftUI

struct AddMovieView: View {
  @StateObject var viewModel: AddMovieViewModel
  @Environment(\.dismiss) var dismiss

  static var df: DateFormatter {
      let df = DateFormatter()
      df.dateStyle = .short
      return df
  }

  let columns = [
    GridItem(.adaptive(minimum: 100))
  ]

  var body: some View {
    ScrollView {
      VStack {

        ZStack {
          Image(systemName: "photo.badge.plus.fill")
            .font(.largeTitle)
            .foregroundStyle(.white)

          PhotosPicker("Select avatar", selection: $viewModel.posterItem, matching: .images)

          LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0), Color.black.opacity(0.9)]),
                         startPoint: .top,
                         endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            .frame(width: 256, height: 384)
            .clipShape(.rect(cornerRadius: 25))
        }

        TextField("Title", text: $viewModel.title, axis: .vertical)
          .multilineTextAlignment(.center)
          .font(.largeTitle)
          .foregroundStyle(.white)
          .fixedSize(horizontal: false, vertical: true)
          .padding()

        HStack {
          ForEach(1...5, id: \.self) { number in
            Button {
              if viewModel.rating == number {
                viewModel.rating = 0
              } else {
                viewModel.rating = number
              }
            } label : {
              Image(systemName: number <= viewModel.rating ? "star.fill" : "star")
                .font(.headline)
                .foregroundStyle(.yellow)
            }
          }
        }
        .padding()

        HStack {
          Text("Release Date: ")
            .foregroundStyle(.white)

          DatePicker("", selection: $viewModel.releaseDate, displayedComponents: .date)
            .labelsHidden()
            .datePickerStyle(.compact)
            .colorScheme(.dark)
        }


        TextField("Description", text: $viewModel.description, axis: .vertical)
          .foregroundStyle(.white)
          .fixedSize(horizontal: false, vertical: true)
          .padding()

        VStack {
          HStack {
            TextField("Add Genre", text: $viewModel.genre)
              .foregroundStyle(.white)
              .onSubmit { viewModel.addGenre() }

            Button("Add") {
              viewModel.addGenre()
            }
            .foregroundStyle(.white)
          }
          .padding()

          LazyVGrid(columns: columns) {
            ForEach(viewModel.genres.sorted(), id: \.self) { genre in
              Text(genre)
                .foregroundStyle(Color.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.black.opacity(0.8))
                .clipShape(Capsule())
                .onTapGesture {
                  viewModel.removeGenre(genre)
                }

            }
          }

        }
        .padding()
      }
    }
    .toolbar {
      Button {
        dismiss()
      } label: {
        Image(systemName: "checkmark")
      }
    }
    .navigationTitle("Add Movie")
    .background(Color.background.ignoresSafeArea(.all))
    
  }
}

#Preview {
  let repository = MovieRepository()
  let useCase = AddMovieUseCase(repository: repository)
  let viewModel = AddMovieViewModel(useCase: useCase)

  NavigationStack {
    AddMovieView(viewModel: viewModel)
  }
}

