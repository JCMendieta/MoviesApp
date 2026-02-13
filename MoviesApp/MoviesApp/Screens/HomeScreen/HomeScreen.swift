//
//  MainScreen.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 13/01/26.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel: HomeScreenVM = HomeScreenVM()
    
    var body: some View {
        ZStack {
            Color.mainScreenBlue.ignoresSafeArea(edges: .top)
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack {
                        Text("Movies App")
                            .styledMainTitle()
                        Image(.filmReel)
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                    .frame(maxWidth: .infinity)
                    
                    if viewModel.isLoading {
                        ProgressView("Loading popular people...")
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundStyle(Color.red)
                    } else if let user = viewModel.mostPopularUser {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Most Popular Person")
                                .font(.title2)
                                .bold()
                            
                            Text(user.name)
                                .font(.headline)
                            
                            Text("Known for: \(user.knownForDepartment)")
                                .font(.subheadline)
                            
                            Text("Popularity: \(user.popularity, specifier: "%.1f")")
                                .font(.subheadline)
                            
                            Divider()
                            
                            Text("Known For Movies / Shows")
                                .font(.headline)
                            
                            ForEach(viewModel.mostPopularUserMovies, id: \.id) { movie in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(movie.title ?? movie.name ?? "Unknown title")
                                        .font(.subheadline)
                                        .bold()
                                    
                                    if !movie.overview.isEmpty {
                                        Text(movie.overview)
                                            .font(.footnote)
                                            .foregroundColor(.primary)
                                            .lineLimit(3)
                                    }
                                    
                                    Text("Media type: \(movie.mediaType)")
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                }
                                .padding(.vertical, 4)
                            }
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 15))
                        }
                    } else {
                        Text("No data available")
                            .foregroundStyle(Color.white)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchPopular()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
