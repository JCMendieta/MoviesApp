//
//  ApiError.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 4/02/26.
//

import Foundation

enum ApiError: Error, Equatable {
    case invalidURL
    case noInternet
    case requestFailed
    case invalidResponse
    case responseStatusNotSuccessful
}
