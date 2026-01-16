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

  let columns = [
    GridItem(.adaptive(minimum: 100))
  ]

  var body: some View {
    let currentImage = viewModel.posterImage

    ScrollView {
      VStack {
        PhotosPicker(selection: $viewModel.posterItem, matching: .images) {
          ZStack {
            if let posterImage = currentImage {
              posterImage
                .resizable()
                .scaledToFill()
                .frame(width: 256, height: 384)
                .clipShape(.rect(cornerRadius: 25))
            } else {
              Image(systemName: "photo.badge.plus.fill")
                .font(.largeTitle)
                .foregroundStyle(.white)
            }


            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0), Color.black.opacity(0.9)]),
                           startPoint: .top,
                           endPoint: .bottom)
              .edgesIgnoringSafeArea(.all)
              .frame(width: 256, height: 384)
              .clipShape(.rect(cornerRadius: 25))
          }
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
          Text("Genres")
            .foregroundStyle(.white)
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
              ZStack(alignment: .topTrailing) {
                Text(genre)
                  .foregroundStyle(Color.white)
                  .padding(.horizontal, 12)
                  .padding(.vertical, 6)
                  .background(Color.black.opacity(0.8))
                  .clipShape(Capsule())
                  .onTapGesture {
                    viewModel.removeGenre(genre)
                  }

                Image(systemName: "xmark")
                  .font(.system(size: 10, weight: .bold))
                  .foregroundColor(.white)
                  .padding(4)
                  .background(Color.red)
                  .clipShape(Circle())
                  .offset(x: 5, y: -5)
              }
              .padding(.top, 5)
              .padding(.trailing, 5)
            }
          }

        }
        .padding()
      }
      .padding()
    }
    .toolbar {
      Button {
        Task {
          await viewModel.saveMovie()
          if viewModel.shouldDismiss {
            dismiss()
          }
        }
      } label: {
        Image(systemName: "checkmark")
      }
      .disabled(!viewModel.isValid || viewModel.isLoading)
    }
    .navigationTitle("Add Movie")
    .background(Color.background.ignoresSafeArea(.all))
    
  }
}
