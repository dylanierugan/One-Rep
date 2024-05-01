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
        HStack {
            HStack {
                Image(systemName: Icons.DumbellFill.description)
                    .foregroundStyle(.linearGradient(colors: [
                        Color("LightBlue"),
                        Color("DarkBlue"),
                    ], startPoint: .top, endPoint: .bottom))
                Spacer()
                DataLabel(data: "12", dataType: "reps")
                Spacer()
                DataLabel(data: "135", dataType: "lbs")
                Spacer()
                Text("2:39pm")
                    .foregroundStyle(.primary)
                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(.secondary.opacity(0.1))
        .cornerRadius(16)
    }
}



#Preview {
    Demo()
}
