//
//  UrlSessionAPIClient.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 4/02/26.
//

import Foundation

protocol ApiClientProtocol {
    func fetchData(from url: URL) async throws -> Data
}

class URLSessionAPIClient: ApiClientProtocol {
    func fetchData(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            if error is URLError {
                throw ApiError.noInternet
            }
            throw ApiError.requestFailed
        }
    }
}
