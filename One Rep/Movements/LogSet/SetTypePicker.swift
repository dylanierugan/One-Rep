//
//  SetTypePicker.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct SetTypePicker: View {
    
    @EnvironmentObject var theme: ThemeModel
    @Binding var setTypeSelection: String
    @Binding var setTypeColor: Color
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 16) {
            SetTypeButton(color: Color(theme.BaseOrange), icon: "flame", iconFilled: "flame.fill", setType: "Warm Up", setTypeSelection: $setTypeSelection, setTypeColor: $setTypeColor)
            SetTypeButton(color: Color("BlueLight"), icon: "dumbbell", iconFilled: "dumbbell.fill", setType: "Working Set", setTypeSelection: $setTypeSelection, setTypeColor: $setTypeColor)
            SetTypeButton(color: Color(theme.BaseYellow), icon: "medal", iconFilled: "medal.fill", setType: "PR", setTypeSelection: $setTypeSelection, setTypeColor: $setTypeColor)
        }
    }
}
