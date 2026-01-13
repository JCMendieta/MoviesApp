//
//  ProfileScreen.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 13/01/26.
//

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        ZStack {
            Color.genericScreenBlue.ignoresSafeArea(edges: .top)
            VStack {
                Text("Movies App")
                    .styledMainTitle()
                Image(.filmReel)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            .padding()
        }
    }
}

#Preview {
    ProfileScreen()
}
