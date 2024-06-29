//
//  Home.swift
//  GlassMorphismNew
//
//  Created by Dylan Ierugan on 4/4/24
//

import Combine
import SwiftUI

struct Demo: View {
        
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                Text("1  Rep")
                    .customFont(size: .largeTitle, weight: .bold, kerning: 0, design: .rounded)
            }
        }
    }
}

#Preview {
    Demo()
}
