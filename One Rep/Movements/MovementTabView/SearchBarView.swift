//
//  SearchBarView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/8/24.
//

import SwiftUI

struct SearchBarView: View {
    
    // MARK: - Global Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Private Variable
    
    @Binding var searchText: String
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Image(systemName: Icons.MagnifyingGlass.rawValue)
                .foregroundColor(
                    Color.secondary.opacity(0.7)
                )
            TextField(MovementsStrings.Search.rawValue, text: $searchText)
                .foregroundColor(Color.secondary.opacity(0.7))
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: Icons.XMarkCircleFill.rawValue)
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.secondary.opacity(0.7))
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }, alignment: .trailing)
        }
        .font(.headline)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(theme.backgroundElementColor)))
    }
}

// MARK: - Extension

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
