//
//  RepositoryTests.swift
//  MoviesAppTests
//
//  Created by Juan Camilo Mendieta Hernández on 17/02/26.
//

import XCTest
@testable import MoviesApp

final class RepositoryTests: XCTestCase {
    var sut: Repository!
    var mockServiceManager: MockServiceManager!

    override func setUp() {
        mockServiceManager = MockServiceManager()
        sut = Repository(servicesManager: mockServiceManager)
    }

    override func tearDown() {
        sut = nil
        mockServiceManager = nil
    }
    
    func testFetchPopularUser_success() async throws {
        // Given
        let mockResponse = PeopleResponse(page: 0, results: [])
        
        mockServiceManager.dataToReturn = mockResponse
        
        // When
        let response = try await sut.fetchPopularUser()
        
        // Then
        XCTAssertEqual(response, mockResponse)
    }
    
    func testFetchPopularUser_failure() async throws {
        // Given
        let expectedError = ApiError.requestFailed
        
        mockServiceManager.errorToThrow = expectedError
        
        // When
        do {
            _ = try await sut.fetchPopularUser()
            XCTFail("Should throw error")
        } catch let error as ApiError {
            // Then
            XCTAssertEqual(error, ApiError.requestFailed)
        }
    }
}
