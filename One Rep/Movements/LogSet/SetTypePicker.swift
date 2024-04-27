//
//  SetTypePicker.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct SetTypePicker: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    @Binding var setTypeSelection: RepType
    @Binding var setTypeColorDark: Color
    @Binding var setTypeColorLight: Color
    
    // MARK: - View
    
    var body: some View {
        HStack(alignment: .center, spacing: 32) {
            SetTypeButton(setTypeSelection: $setTypeSelection, setTypeColorDark: $setTypeColorDark, setTypeColorLight: $setTypeColorLight, darkColor: Color(theme.darkOrange), lightColor: Color(theme.lightOrange), icon: "flame", iconFilled: "flame.fill", setType: .WarmUp)
            SetTypeButton(setTypeSelection: $setTypeSelection, setTypeColorDark: $setTypeColorDark, setTypeColorLight: $setTypeColorLight, darkColor: Color(theme.darkBlue), lightColor: Color(theme.lightBlue), icon: "dumbbell", iconFilled: "dumbbell.fill", setType: .WorkingSet)
            SetTypeButton(setTypeSelection: $setTypeSelection, setTypeColorDark: $setTypeColorDark, setTypeColorLight: $setTypeColorLight, darkColor: Color(theme.darkYellow), lightColor: Color(theme.lightYellow), icon: "medal", iconFilled: "medal.fill", setType: .PR)
        }
    }
}
