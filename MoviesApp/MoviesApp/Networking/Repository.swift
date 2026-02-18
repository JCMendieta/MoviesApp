//
//  Repository.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 4/02/26.
//

import Foundation

protocol RepositoryProtocol {
    func fetchPopularUser() async throws -> PeopleResponse
}

class Repository: RepositoryProtocol {
    private let servicesManager: ServicesManagerProtocol
    
    init(servicesManager: ServicesManagerProtocol = ServicesManager(apiClient: URLSessionAPIClient(), dataDecoder: JSONDecoderWrapper())) {
        self.servicesManager = servicesManager
    }
    
    func fetchPopularUser() async throws -> PeopleResponse {
        let apiUrl = try MoviesEndpoint.popularUser().asUrl()
        return try await servicesManager.request(apiUrl, entity: PeopleResponse.self)
    }
}
