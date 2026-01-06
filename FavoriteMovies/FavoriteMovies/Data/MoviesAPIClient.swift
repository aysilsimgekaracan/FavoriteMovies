//
//  MoviesAPIClient.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 3.01.2026.
//

import Foundation

final class MoviesAPIClient {
  private let baseURL: URL
  private let session: URLSession
  private let decoder: JSONDecoder

  init(baseURL: URL, session: URLSession = .shared) {
    self.baseURL = baseURL
    self.session = session

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    self.decoder = decoder
  }

  func fetchMovies() async throws -> [MovieDTO] {
    let url = baseURL.appendingPathComponent("movies")
    let (data, response) = try await session.data(from: url)

    guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
      throw URLError(.badServerResponse)
    }

    return try decoder.decode([MovieDTO].self, from: data)
  }
}
