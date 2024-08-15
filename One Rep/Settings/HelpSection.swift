//
//  HelpSection.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/13/24.
//

import SwiftUI

struct HelpSection: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Private Properties
    
    @State var showContactSheet = false
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(HelpSectionStrings.Help.rawValue)
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary)
            VStack(alignment: .leading) {
                HStack {
                    Button {
                        showContactSheet.toggle()
                    } label: {
                        Text(HelpSectionStrings.ContactSupport.rawValue)
                            .font(.body.weight(.bold))
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(Color(theme.backgroundElementColor))
            .cornerRadius(16)
            .sheet(isPresented: $showContactSheet) {
                ContactSupportSheet()
                    .environment(\.colorScheme, theme.colorScheme)
            }
        }
    }
}
