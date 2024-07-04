//
//  ShowFullScreenButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

struct ShowFullScreenButton: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    @State var icon = Icons.ChevronCompactUp.rawValue
    
    @Binding var showLogSetView: Bool
    
    // MARK: - View
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.showLogSetView.toggle()
                if showLogSetView {
                    icon = Icons.ChevronCompactUp.rawValue
                } else {
                    icon = Icons.ChevronCompactDown.rawValue
                }
            }
        }, label: {
            ZStack {
                Image(systemName: icon)
                    .foregroundColor(.primary)
                    .font(.title2.weight(.semibold))
            }
        })
    }
}
