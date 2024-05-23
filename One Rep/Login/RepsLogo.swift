//
//  RepsLogo.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI

struct RepsLogo: View {
    
    var size: CGFloat
    
    var body: some View {
        Text("1 Rep")
            .customFont(size: .title, weight: .bold, kerning: 0, design: .rounded)
            .foregroundColor(.primary)
            .kerning(-1)
    }
}
