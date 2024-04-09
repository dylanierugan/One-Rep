//
//  ThemeColorModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/6/24.
//

import Foundation

class ThemeColorModel: ObservableObject {
    
    init(accent: String) {
        self.accent = accent
        self.Background = Colors.BackgroundColor.description
        self.BackgroundElement = Colors.BackgroundElementColor.description
        if accent == Colors.Green.description {
            self.Base = Colors.GreenBase.description
            self.BaseLight = Colors.GreenNeon.description
            self.BaseDark = Colors.GreenCyan.description
        } else if accent == Colors.Pink.description {
            self.Base = Colors.PinkBase.description
            self.BaseLight = Colors.PinkLight.description
            self.BaseDark = Colors.PinkPurple.description
        } else {
            self.Base = Colors.GreenBase.description
            self.BaseLight = Colors.GreenNeon.description
            self.BaseDark = Colors.GreenCyan.description
        }
    }
    
    @Published var accent: String
    
    @Published var Base: String
    @Published var BaseLight: String
    @Published var BaseDark: String
    @Published var Background: String
    @Published var BackgroundElement: String
    
    func changeColor(color: String) {
        if color == Colors.Green.description {
            self.Base = Colors.GreenBase.description
            self.BaseLight = Colors.GreenNeon.description
            self.BaseDark = Colors.GreenCyan.description
        } else if accent == Colors.Pink.description {
            self.Base = Colors.PinkBase.description
            self.BaseLight = Colors.PinkLight.description
            self.BaseDark = Colors.PinkPurple.description
        }
    }
    
}
