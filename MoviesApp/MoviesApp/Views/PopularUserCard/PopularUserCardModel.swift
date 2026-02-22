//
//  PopularUserCardModel.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 18/02/26.
//

import Foundation

struct PopularUserCardModel {
    let id: Int
    let knownFor: String
    let name: String
    let popularity: String
    let imageURL: URL?
    
    init(popularUser: Result) {
        id = popularUser.id
        knownFor = popularUser.knownForDepartment
        name = popularUser.name
        popularity = String(format:"%.2f", popularUser.popularity)
        // MARK: Fix
        imageURL = URL(string: "https://image.tmdb.org/t/p/w500/" + popularUser.profilePath)
    }
}
