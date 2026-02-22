//
//  MovieCardModel.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 20/02/26.
//

import Foundation

struct MovieCardModel {
    let id: Int
    let posterImageURL: URL?
    let title: String
    let popularity: Double
    let overview: String
    
    init(movie: KnownFor) {
        self.id = movie.id
        self.posterImageURL = URL(string: "https://image.tmdb.org/t/p/w500/" + movie.posterPath)
        self.title = movie.title ?? "No title found"
        self.popularity = movie.popularity
        self.overview = movie.overview
    }
}
