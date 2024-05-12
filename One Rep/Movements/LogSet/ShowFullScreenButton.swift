//
//  ShowFullScreenButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

struct ShowFullScreenButton: View {
    
    @EnvironmentObject var theme: ThemeModel
    
    @State var icon = Icons.ChevronCompactUp.description
    
    @Binding var showLogSetView: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.showLogSetView.toggle()
                if showLogSetView {
                    icon = Icons.ChevronCompactUp.description
                } else {
                    icon = Icons.ChevronCompactDown.description
                }
            }
        }, label: {
            ZStack {
                Image(systemName: icon)
                    .foregroundColor(.primary)
                    .font(.title3.weight(.semibold))
            }
        })
    }
}
