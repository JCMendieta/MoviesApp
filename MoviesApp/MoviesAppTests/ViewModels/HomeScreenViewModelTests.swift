//
//  HomeScreenViewModelTests.swift
//  MoviesAppTests
//
//  Created by Juan Camilo Mendieta Hernández on 22/02/26.
//

import XCTest
@testable import MoviesApp

final class HomeScreenViewModelTests: XCTestCase {
    var sut: HomeScreenVM!
    var mockRepository: MockRepository!

    override func setUp() {
        mockRepository = MockRepository()
        sut = HomeScreenVM(repository: mockRepository)
    }

    override func tearDown() {
        mockRepository = nil
        sut = nil
    }
    
    func testFetchPopular_success() async throws {
        // Given
        let mockData = PeopleResponse(page: 1, results: [
            Result(adult: true, gender: 1, id: 12, knownForDepartment: "Acting", name: "Test Testing", originalName: "Test Testing T", popularity: 12, profilePath: "", knownFor: [])
        ])

        mockRepository.dataToReturn = mockData
        
        //When
        await sut.fetchPopular()
        
        //Then
        XCTAssertEqual(sut.mostPopularUser, mockData.results[0])
        XCTAssertEqual(sut.people, mockData.results)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testFetchPopular_failure() async throws {
        // Given
        let mockError = ApiError.requestFailed
        
        mockRepository.errorToThrow = mockError
        
        // When
        await sut.fetchPopular()
        
        // Then
        XCTAssertEqual(sut.errorMessage, ApiError.requestFailed.localizedDescription)
    }
}
