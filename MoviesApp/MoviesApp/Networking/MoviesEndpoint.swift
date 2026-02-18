//
//  MoviesEndpoint.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 5/02/26.
//

import Foundation

enum MoviesEndpoint {
    case popularUser(page: Int = 1)
    
    var path: String {
        switch self {
        case .popularUser:
            return "/person/popular"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem(name: "api_key", value: ApiConfig.apiKey)]
        
        switch self {
        case .popularUser(let page):
            items.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        return items
    }
    
    func asUrl() throws -> URL {
        guard let baseURL = URL(string: ApiConfig.baseURL) else {
            throw ApiError.invalidURL
        }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        
        let existingPath = components?.path ?? ""
        
        components?.path = existingPath + path
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw ApiError.invalidURL
        }
        
        return url
    }
}
