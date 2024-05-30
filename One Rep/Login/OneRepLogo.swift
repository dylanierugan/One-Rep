//
//  RepsLogo.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI

struct OneRepLogo: View {
    
    var size: Font.TextStyle
    
    var body: some View {
        Text("1 Rep")
            .customFont(size: size, weight: .bold, kerning: 0, design: .rounded)
            .foregroundColor(.primary)
            .kerning(-1)
    }
}
