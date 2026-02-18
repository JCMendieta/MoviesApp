//
//  URLSessionAPIClientTests.swift
//  MoviesAppTests
//
//  Created by Juan Camilo Mendieta Hernández on 12/02/26.
//

import XCTest
@testable import MoviesApp

final class URLSessionAPIClientTests: XCTestCase {
    var sut: URLSessionAPIClient!
    var mockSession: URLSession!
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockSession = URLSession(configuration: config)
        sut = URLSessionAPIClient(session: mockSession)
    }
    
    override func tearDown() {
        MockURLProtocol.requestHandler = nil
        sut = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testFetchData_success() async throws {
        // Given
        let expectedData = "Test data".data(using: .utf8)!
        let url = URL(string: "https://api.test.com")!
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, expectedData)
        }
        
        // When
        let data = try await sut.fetchData(from: url)
        
        // Then
        XCTAssertEqual(data, expectedData)
    }
    
    func testFetchData_invalidResponse() async throws {
        //Given
        let expectedData = "Test data".data(using: .utf8)!
        let url = URL(string: "https://api.test.com")!
        
        MockURLProtocol.requestHandler = { request in
            let response = URLResponse(
                url: url,
                mimeType: nil,
                expectedContentLength: 0,
                textEncodingName: nil
            )
            return (response, expectedData)
        }
        
        //When
        do {
            _ = try await sut.fetchData(from: url)
        } catch let error as ApiError {
            
            // Then
            XCTAssertEqual(error, ApiError.invalidResponse)
        }
    }
    
    func testFetchData_responseStatusNotSuccessful() async throws {
        // Given
        let expectedData = "Test data".data(using: .utf8)!
        let url = URL(string: "https://api.test.com")!
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 400,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, expectedData)
        }
        
        // When
        do {
            let _ = try await sut.fetchData(from: url)
        } catch let error as ApiError {
            
            //Then
            XCTAssertEqual(error, ApiError.responseStatusNotSuccessful)
        }
    }
}

//MARK: - Mock URLProtocol
class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (URLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}
