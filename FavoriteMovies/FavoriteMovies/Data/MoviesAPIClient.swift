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
  private let encoder: JSONEncoder

  init(baseURL: URL, session: URLSession = .shared) {
    self.baseURL = baseURL
    self.session = session

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    self.decoder = decoder

    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    self.encoder = encoder
  }

  func fetchMovies() async throws -> [MovieDTO] {
    let url = baseURL.appendingPathComponent("movies")
    let (data, response) = try await session.data(from: url)

    guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
      throw URLError(.badServerResponse)
    }

    return try decoder.decode([MovieDTO].self, from: data)
  }

  func createMovie(_ requestDTO: CreateMovieRequestDTO) async throws -> MovieDTO {
    let url = baseURL.appendingPathComponent("movies")
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try encoder.encode(requestDTO)

    let (data, response) = try await session.data(for: request)
    try validate(response: response)
    return try decoder.decode(MovieDTO.self, from: data)
  }

  func uploadPoster(movieID: UUID, jpegData: Data) async throws -> MovieDTO {
    let url = baseURL
      .appendingPathComponent("movies")
      .appendingPathComponent(movieID.uuidString)
      .appendingPathComponent("poster")

    let boundary = "Boundary-\(UUID().uuidString)"
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    request.httpBody = makeMultipartBody(boundary: boundary,
                                         fieldName: "file",
                                         fileName: "poster.jpg",
                                         mimeType: "image/jpeg",
                                         fileData: jpegData)
    let (data, response) = try await session.data(for: request)
    try validate(response: response)
    return try decoder.decode(MovieDTO.self, from: data)
  }

  // MARK: Private Helpers

  private func validate(response: URLResponse) throws {
    guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
      throw URLError(.badServerResponse)
    }
  }

  private func makeMultipartBody(
    boundary: String,
    fieldName: String,
    fileName: String,
    mimeType: String,
    fileData: Data
  ) -> Data {
    var body = Data()

    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
    body.append(fileData)
    body.append("\r\n".data(using: .utf8)!)
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)

    return body
  }
}
