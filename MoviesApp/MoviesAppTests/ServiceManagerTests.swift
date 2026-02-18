//
//  ServiceManagerTests.swift
//  MoviesAppTests
//
//  Created by Juan Camilo Mendieta Hernández on 17/02/26.
//

import XCTest
@testable import MoviesApp

final class ServiceManagerTests: XCTestCase {
    
    var sut: ServicesManager!
    var mockDataDecoder: MockDataDecoder!
    var mockApiClient: MockAPIClient!

    override func setUp() {
        mockApiClient = MockAPIClient()
        mockDataDecoder = MockDataDecoder()
        sut = ServicesManager(apiClient: mockApiClient, dataDecoder: mockDataDecoder)
        
        mockApiClient.mockData = """
            {
                "id": "1",
                "nam": "test"
            }
            """.data(using: .utf8)
        mockDataDecoder.entityToReturn = TestDecodableData(id: 1, name: "test")
    }

    override func tearDown() {
        mockApiClient = nil
        mockDataDecoder = nil
        sut = nil
    }
    
    func testRequest_success() async throws {
        // Given
        let expectedEntity = TestDecodableData(id: 1, name: "test")
        
        let mockURL = URL(string: "https://api.test.com")!
        
        // When
        let data = try await sut.request(mockURL, entity: TestDecodableData.self)
        
        //Then
        XCTAssertEqual(data, expectedEntity)
    }
    
    func testRequest_dataDecoderError() async throws {
        // Given
        let mockURL = URL(string: "https://api.test.com")!
        let expectedError = ApiError.requestFailed
        
        mockDataDecoder.errorToThrow = expectedError
        
        // When
        do {
            _ = try await sut.request(mockURL, entity: TestDecodableData.self)
            XCTFail("Should throw error.")
            
        } catch let error as ApiError {
            // Then
            XCTAssertEqual(error, ApiError.requestFailed)
        }
    }
    
    func testRequest_APIClientError() async throws {
        // Given
        let mockURL = URL(string: "https://api.test.com")!
        let expectedError = ApiError.requestFailed
        
        mockApiClient.errorToThrow = expectedError
        
        // When
        do {
            _ = try await sut.request(mockURL, entity: TestDecodableData.self)
            XCTFail("Should throw error.")
        } catch let error as ApiError {
            //Then
            XCTAssertEqual(error, ApiError.requestFailed)
        }
    }
}


