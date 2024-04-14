//
//  ThemeColorModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/6/24.
//

import Foundation

class ThemeModel: ObservableObject {
    
    init(accent: String) {
        self.accent = accent
        self.BackgroundColor = Colors.BackgroundColor.description
        self.BackgroundElementColor = Colors.BackgroundElementColor.description
        self.BaseBlue = Colors.BlueBase.description
        self.BaseOrange = Colors.OrangeBase.description
        self.BaseYellow = Colors.YellowBase.description
        if accent == Colors.Green.description {
            self.BaseColor = Colors.GreenBase.description
            self.BaseLightColor = Colors.GreenNeon.description
            self.BaseDarkColor = Colors.GreenCyan.description
        } else if accent == Colors.Pink.description {
            self.BaseColor = Colors.PinkBase.description
            self.BaseLightColor = Colors.PinkLight.description
            self.BaseDarkColor = Colors.PinkPurple.description
        } else {
            self.BaseColor = Colors.GreenBase.description
            self.BaseLightColor = Colors.GreenNeon.description
            self.BaseDarkColor = Colors.GreenCyan.description
        }
    }
    
    @Published var accent: String
    
    @Published var BaseColor: String
    @Published var BaseLightColor: String
    @Published var BaseDarkColor: String
    
    @Published var BaseBlue: String
    @Published var BaseOrange: String
    @Published var BaseYellow: String
    
    @Published var BackgroundColor: String
    @Published var BackgroundElementColor: String
    
    func changeColor(color: String) {
        if color == Colors.Green.description {
            self.BaseColor = Colors.GreenBase.description
            self.BaseLightColor = Colors.GreenNeon.description
            self.BaseDarkColor = Colors.GreenCyan.description
        } else if accent == Colors.Pink.description {
            self.BaseColor = Colors.PinkBase.description
            self.BaseLightColor = Colors.PinkLight.description
            self.BaseDarkColor = Colors.PinkPurple.description
        }
    }
    
}
