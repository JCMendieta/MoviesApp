//
//  HomeScreenVM.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 5/02/26.
//

import Foundation

class HomeScreenVM: ObservableObject {
    private var repository: RepositoryProtocol
    
    @Published var people: [Result] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var mostPopularUser: Result? {
        people.first
    }
    
    var mostPopularUserMovies: [KnownFor] {
        mostPopularUser?.knownFor ?? []
    }
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
    }
    
    @MainActor
    func fetchPopular() async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await repository.fetchPopularUser()
            people = response.results
        } catch {
            errorMessage = error.localizedDescription
            print("Error fetching popular users: \(error)")
        }
        
        isLoading = false
    }
}

