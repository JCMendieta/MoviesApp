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
                VStack(alignment: .center, spacing: 16) {
                    VStack {
                        Text("Movies App")
                            .styledMainTitle()
                        Image(.filmReel)
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Text("Today's Popular User")
                        .font(.title)
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                    
                    if viewModel.isLoading {
                        ProgressView("Loading popular people...")
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundStyle(Color.red)
                    } else if let _ = viewModel.mostPopularUser {
                        VStack(alignment: .center, spacing: 8) {
                            
                            PopularUserCardView(model: PopularUserCardModel(popularUser: viewModel.mostPopularUser!))
                            
                            Text("Popular movies")
                                .font(.title)
                                .foregroundStyle(Color.white)
                                .fontWeight(.bold)
                            
                            VStack(alignment: .leading, spacing: 10) {
                            ForEach(viewModel.mostPopularUserMovies, id: \.id) { movie in
                                
                                    MovieCardView(model: MovieCardModel(movie: movie))
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
