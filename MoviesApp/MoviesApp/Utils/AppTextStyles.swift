//
//  AppTextStyles.swift
//  MoviesApp
//
//  Created by Juan Camilo Mendieta Hernández on 13/01/26.
//

import SwiftUI

extension Text {
    func styledMainTitle() -> some View {
        self
            .font(.largeTitle)
            .fontWeight(.bold)
            .textCase(.uppercase)
            .foregroundStyle(.white)
    }
}
