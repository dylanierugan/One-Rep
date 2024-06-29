//
//  FontModifier.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/6/24.
//

import SwiftUI

struct FontModifier: ViewModifier {
    var size: Font.TextStyle
    var weight: Font.Weight
    var kerning: CGFloat
    var design: Font.Design

    func body(content: Content) -> some View {
        content
            .font(.system(size, design: design))
            .fontWeight(weight)
            .kerning(kerning)
    }
}

extension View {
    func customFont(size: Font.TextStyle = .body, weight: Font.Weight = .regular, kerning: CGFloat = 0, design: Font.Design = .default) -> some View {
        self.modifier(FontModifier(size: size, weight: weight, kerning: kerning, design: design))
    }
}
