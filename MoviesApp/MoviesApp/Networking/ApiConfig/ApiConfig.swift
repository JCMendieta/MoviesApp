//
//  ApiConfig.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 5/02/26.
//

import Foundation

struct ApiConfig {
    static let apiKey: String = {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path),
              let apiKey = config["TMDB_API_KEY"] as? String, !apiKey.isEmpty else {
            fatalError("TMDB_API_KEY not found in Config.plist. Please create Config.plist from Config.plist.example")
        }
        return apiKey
    }()
    
    static let baseURL: String = {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"), let config = NSDictionary(contentsOfFile: path),
              let baseUrl = config["TMDB_BASE_URL"] as? String else {
            return "https://api.themoviedb.org/3"
        }
        return baseUrl
    }()
}
