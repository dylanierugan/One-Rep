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
            .font(.title.weight(.heavy))
            .foregroundColor(.white)
            .kerning(-1)
    }
}
