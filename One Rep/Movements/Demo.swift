//
//  Home.swift
//  GlassMorphismNew
//
//  Created by Dylan Ierugan on 4/4/24
//

import Combine
import SwiftUI

struct Demo: View {
    
    @State var movementSelection: MovementSelection = .Library
    
    var body: some View {
        HStack {
            ForEach(MovementSelection.allCases, id: \.rawValue) { selection in
                Button(action: {
                    withAnimation {
                        movementSelection = selection
                        HapticManager.instance.impact(style: .soft)
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Text(selection.rawValue)
                            .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .foregroundStyle(movementSelection == selection  ? Color("ReversePrimary"): .primary)
                    .background(movementSelection == selection ? Color("Primary") : .clear)
                    .cornerRadius(16)
                    .padding(6)
                })
            }
        }
        .background(Color("BackgroundElementColor"))
        .cornerRadius(16)
        .padding(.horizontal, 16)
    }
}



#Preview {
    Demo()
}
