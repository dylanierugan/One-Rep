//
//  RepsLogo.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI

struct OneRepLogo: View {
    
    // MARK: - Public Properties
    
    var size: Font.TextStyle
    
    // MARK: - View
    
    var body: some View {
        Text(LogoString.OneRep.rawValue)
            .customFont(size: size, weight: .bold, kerning: 0, design: .rounded)
            .foregroundColor(.primary)
            .kerning(-1)
    }
}
