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
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        guard(200...299).contains(httpResponse.statusCode) else {
            throw ApiError.responseStatusNotSuccessful
        }
        
        return data
    }
}
