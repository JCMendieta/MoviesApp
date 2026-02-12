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
            VStack {
                Text("Movies App")
                    .styledMainTitle()
                Image(.filmReel)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            .padding()
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
