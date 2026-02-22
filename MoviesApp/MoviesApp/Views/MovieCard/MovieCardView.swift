//
//  MovieCardView.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 20/02/26.
//

import SwiftUI

struct MovieCardView: View {
    let model: MovieCardModel
    
    init(model: MovieCardModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: model.posterImageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                case .failure:
                    Image(systemName: "person.fill")
                        .resizable()
                default:
                    ProgressView()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .padding(0)
            .clipShape(RoundedRectangle(cornerRadius: 2))
            
            VStack (alignment: .leading, spacing: 16){
                Text("Name: \(model.title)")
                Text("Description: \(model.overview)")
                Text("Popularity: \(model.popularity)")
            }
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(Color.white)
            .padding(12)
        }
        .background(Color.mediumBlue)
        .clipShape(RoundedRectangle(cornerRadius: 2))
    }
}

#Preview {
    MovieCardView(model: MovieCardModel(movie: KnownFor(adult: false, backdropPath: "", id: 1, title: "Test title", originalTitle: "test title", overview: "This is the test movie starring test testing", posterPath: "/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg", mediaType: "", originalLanguage: "", genreIDS: [], popularity: 12, releaseDate: "", video: false, voteAverage: 12, voteCount: 12, name: "Test", originalName: "Test", firstAirDate: "", originCountry: [])))
        .frame(width: 350)
}
