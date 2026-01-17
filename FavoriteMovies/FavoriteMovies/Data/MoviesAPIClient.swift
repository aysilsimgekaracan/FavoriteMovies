//
//  MoviesAPIClient.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 3.01.2026.
//

import Foundation

/// Errors produced by `MoviesAPIClient`.
enum MoviesAPIError: Error, LocalizedError {
  case invalidResponse
  case httpError(statusCode: Int, body: Data?)
  case decodingError(Error)

  var errorDescription: String? {
    switch self {
    case .invalidResponse:
      return "Invalid server response."
    case .httpError(let statusCode, _):
      return "Server error (HTTP \(statusCode))."
    case .decodingError:
      return "Failed to decode server response."
    }
  }
}

final class MoviesAPIClient {
  private let baseURL: URL
  private let session: URLSession
  private let decoder: JSONDecoder
  private let encoder: JSONEncoder

  /// Creates a Movies API client.
  /// - Parameters:
  ///   - baseURL: Base URL of the backend
  ///   - session: URLSession used for requests.
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

  // MARK: - Endpoints

  /// Fetches all movies.
  func fetchMovies() async throws -> [MovieDTO] {
    let url = baseURL.appendingPathComponent("movies")
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    let data = try await perform(request, allowEmptyBody: false)
    do {
      return try decoder.decode([MovieDTO].self, from: data)
    } catch {
      throw MoviesAPIError.decodingError(error)
    }
  }

  /// Creates a movie
  func createMovie(_ dto: CreateMovieRequestDTO) async throws -> MovieDTO {
    let url = baseURL.appendingPathComponent("movies")
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpBody = try encoder.encode(dto)

    let data = try await perform(request, allowEmptyBody: false)
    do {
      return try decoder.decode(MovieDTO.self, from: data)
    } catch {
      throw MoviesAPIError.decodingError(error)
    }
  }

  /// Deletes a movie by id.
  func deleteMovie(id: UUID) async throws {
    let url = baseURL
      .appendingPathComponent("movies")
      .appendingPathComponent(id.uuidString)

    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    _ = try await perform(request, allowEmptyBody: true)
  }

  /// Uploads a poster JPEG for an existing movie.
  ///
  /// - Parameters:
  ///   - movieID: Movie identifier.
  ///   - jpegData: JPEG image bytes.
  /// - Returns: Updated movie returned by the backend.
  func uploadPoster(movieID: UUID, jpegData: Data) async throws -> MovieDTO {
    let url = baseURL
      .appendingPathComponent("movies")
      .appendingPathComponent(movieID.uuidString)
      .appendingPathComponent("poster")

    let boundary = "Boundary-\(UUID().uuidString)"

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    request.httpBody = makeMultipartBody(
      boundary: boundary,
      fieldName: "file",
      fileName: "poster.jpg",
      mimeType: "image/jpeg",
      fileData: jpegData
    )

    let data = try await perform(request, allowEmptyBody: false)
    do {
      return try decoder.decode(MovieDTO.self, from: data)
    } catch {
      throw MoviesAPIError.decodingError(error)
    }
  }

  // MARK: - Core request executor

  /// Performs a request and returns response data.
  /// - Parameter allowEmptyBody: If true, empty body is accepted (e.g., DELETE 204).
  private func perform(_ request: URLRequest, allowEmptyBody: Bool) async throws -> Data {
    let (data, response) = try await session.data(for: request)

    guard let http = response as? HTTPURLResponse else {
      throw MoviesAPIError.invalidResponse
    }

    guard (200...299).contains(http.statusCode) else {
      throw MoviesAPIError.httpError(statusCode: http.statusCode, body: data)
    }

    if allowEmptyBody, data.isEmpty {
      return Data()
    }

    return data
  }

  // MARK: - Multipart builder

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
