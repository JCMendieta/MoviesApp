//
//  Mocks.swift
//  MoviesAppTests
//
//  Created by Juan Camilo Mendieta Hernández on 17/02/26.
//

import Foundation
@testable import MoviesApp

//MARK: - Networking Mock Data Structure

struct TestDecodableData: Decodable, Equatable {
    let id: Int
    let name: String
}

class MockDataDecoder: DataDecoderProtocol {
    var entityToReturn: Any!
    var errorToThrow: Error?
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if let error = errorToThrow {
            throw error
        }
        
        return entityToReturn as! T
    }
}

class MockAPIClient: ApiClientProtocol {
    var mockData: Data!
    var errorToThrow: Error?
    
    func fetchData(from url: URL) async throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        
        return mockData
    }
}

class MockServiceManager: ServicesManagerProtocol {
    var dataToReturn: Any!
    var errorToThrow: Error?
    
    func request<T>(_ url: URL, entity: T.Type) async throws -> T where T : Decodable {
        if let error = errorToThrow {
            throw error
        }
        
        return dataToReturn as! T
    }
}

class MockRepository: RepositoryProtocol {
    var dataToReturn: PeopleResponse!
    var errorToThrow: Error?
    
    func fetchPopularUser() async throws -> PeopleResponse {
        
        if let error = errorToThrow {
            throw error
        }
        
        return dataToReturn
    }
    
}
