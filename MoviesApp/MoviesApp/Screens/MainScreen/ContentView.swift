//
//  ContentView.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 8/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
                Tab("Home", systemImage: "movieclapper") {
                    HomeScreen()
                }
                
                Tab("Profile", systemImage: "person.crop.circle") {
                    ProfileScreen()
                }
        }
        .toolbarBackground(.white, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .tint(.mainScreenBlue)
    }
}

#Preview {
    ContentView()
}
