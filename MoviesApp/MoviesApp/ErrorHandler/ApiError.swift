//
//  ApiError.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 4/02/26.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case noInternet
    case requestFailed
}
