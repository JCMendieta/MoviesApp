//
//  Repository.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 4/02/26.
//

import Foundation

protocol RepositoryProtocol {
    func fetchMovies()
}

class Repository: RepositoryProtocol {
    private let servicesManager: ServicesManagerProtocol
    
    init(servicesManager: ServicesManagerProtocol = ServicesManager(apiClient: URLSessionAPIClient(), dataDecoder: JSONDecoderWrapper())) {
        self.servicesManager = servicesManager
    }
    
    func fetchMovies() {
        
    }
}
