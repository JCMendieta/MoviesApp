//
//  PopularUserCardView.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 18/02/26.
//

import SwiftUI

struct PopularUserCardView: View {
    let model: PopularUserCardModel
    
    init(model: PopularUserCardModel) {
        self.model = model
    }
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: model.imageURL) { phase in
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
            .frame(
                width: 150,
                height: 150
            )
            .clipShape(RoundedRectangle(cornerRadius: 22))
            
            VStack (alignment: .leading, spacing: 16){
                Text("Name: \(model.name)")
                Text("Known for: \(model.knownFor)")
                Text("Popularity: \(model.popularity)")
            }
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(Color.white)
        }
        .padding(12)
        .background(Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    PopularUserCardView(model: PopularUserCardModel(popularUser: Result(adult: true, gender: 2, id: 13, knownForDepartment: "Acting", name: "test testing", originalName: "test", popularity: 12.4, profilePath: "3tcKxC5Sc3DJ6XPDKKC2EAomEWn.jpg", knownFor: [])))
}
