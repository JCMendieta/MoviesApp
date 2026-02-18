//
//  DataDecoderTests.swift
//  MoviesAppTests
//
//  Created by Juan Camilo Mendieta Hernández on 16/02/26.
//

import XCTest
@testable import MoviesApp

final class DataDecoderTests: XCTestCase {
    var sut: JSONDecoderWrapper!
    
    override func setUp()  {
        sut = JSONDecoderWrapper()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testDecodeJSON_Success() throws {
        // Given
        let testData = TestDecodableData(id: 1, name: "test")
        let testDataJSON = """
            {
                "id": 1,
                "name": "test"
            }
            """.data(using: .utf8)!
        
        // When
        let decodedData = try sut.decode(TestDecodableData.self, from: testDataJSON)
        
        // Then
        XCTAssertEqual(testData, decodedData)
    }
    
    func testDecodeJSON_throwsDecodingError() throws {
        // Given
        let testDataJSON = """
            {
                "id": "1",
                "nam": "test"
            }
            """.data(using: .utf8)!
        
        // When/Then
        XCTAssertThrowsError(try sut.decode(TestDecodableData.self, from: testDataJSON)) { error in
            XCTAssert(error is DecodingError, "Should throw DecodingError" )
        }
    }
}
