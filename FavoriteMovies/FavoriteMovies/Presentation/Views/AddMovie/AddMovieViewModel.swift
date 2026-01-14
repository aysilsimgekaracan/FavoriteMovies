//
//  AddMovieViewModel.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 29.12.2025.
//

import Combine
import PhotosUI
import SwiftUI

@MainActor
class AddMovieViewModel: ObservableObject {
  // MARK: Published Properties

  @Published var title: String = ""
  @Published var rating: Int = 0
  @Published var description: String = ""
  @Published var releaseDate: Date = Date()
  @Published var genre: String = ""
  @Published var genres: Set<String> = ["test1", "test2", "test3"]

  @Published var posterImage: Image?
  @Published var posterItem: PhotosPickerItem? {
    didSet {
      Task {
        await loadPoster()
      }
    }
  }
  @Published private(set) var posterJPEGData: Data?

  // MARK: State Properties

  @Published var isLoading: Bool = false
  @Published var errorMessage: String?
  @Published var shouldDismiss: Bool = false

  // MARK: Dependencies

  private let useCase: AddMovieUseCase

  // MARK: Initialization

  init(useCase: AddMovieUseCase) {
    self.useCase = useCase
  }

  // MARK: - Validation

  var isValid: Bool {
    !title.trimmingCharacters(in: .whitespaces).isEmpty &&
    !description.trimmingCharacters(in: .whitespaces).isEmpty &&
    rating >= 1 && rating <= 5
  }

  // MARK: User Intents

  func toogleRating(_ number: Int) {
    if rating == number {
      rating = 0
    } else {
      rating = number
    }
  }

  func addGenre() {
    let trimmed = genre.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else { return }
    genres.insert(trimmed)
    genre = ""
  }

  func removeGenre(_ genre: String) {
    genres.remove(genre)
  }

  // MARK: Actions

  func saveMovie() async {
    guard isValid else { return }

    isLoading = true
    errorMessage = nil

    do {
      _ = try await useCase.execute(
        title: title.trimmingCharacters(in: .whitespacesAndNewlines),
        description: description.trimmingCharacters(in: .whitespacesAndNewlines),
        rating: rating,
        genres: Array(genres),
        releaseDate: releaseDate,
        posterJPEGData: posterJPEGData
      )

      shouldDismiss = true
    } catch {
      errorMessage = "Failed to add movie. \(error.localizedDescription)"
    }

    isLoading = false
  }

  func loadPoster() async {
    guard let item = posterItem else { return }

    do {
      guard let data = try await item.loadTransferable(type: Data.self),
         let uiImage = UIImage(data: data) else {
        return
      }

      self.posterImage = Image(uiImage: uiImage)

      posterJPEGData = uiImage.jpegData(compressionQuality: 0.85)

    } catch {
      errorMessage = "Failed to load poster. \(error.localizedDescription)"
    }
  }

  func clearForm() {
    title = ""
    rating = 0
    description = ""
    releaseDate = Date()
    genres = ["test1", "test2", "test3"]
    genre = ""
    posterItem = nil
    posterImage = nil
    errorMessage = nil
    shouldDismiss = false
    isLoading = false
  }
}
