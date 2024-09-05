//
//  RoutineIconPicker.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/22/24.
//

import SwiftUI

struct RoutineIconPicker: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    @Binding var selectedIcon: String
    
    // MARK: - Private Properties
    
    var icons: [String] = [Icons.Bench.rawValue, Icons.FigureStrengthTraining.rawValue,
                           Icons.FigureStrengthTrainingFunctional.rawValue,
                           Icons.FigureRower.rawValue,
                           Icons.FigureHighIntensityIntervaltraining.rawValue,
                           Icons.FigureCoreTraining.rawValue,
                           Icons.DumbellFill.rawValue,
                           Icons.CircleFill.rawValue,
                           Icons.TriangleFill.rawValue,
                           Icons.SquareFill.rawValue,
                           Icons.HeartFill.rawValue,
                           Icons.CircleHexagongrid.rawValue,
                           Icons.Atom.rawValue]
    
    // MARK: - View
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(icons, id: \.self) { icon in
                    Button {
                        selectedIcon = icon
                        HapticManager.instance.impact(style: .soft)
                    } label: {
                        HStack {
                            if icon == Icons.Bench.rawValue {
                                Image(Icons.Bench.rawValue)
                                    .font(.caption.weight(.regular))
                            } else {
                                Image(systemName: icon)
                                    .font(.body.weight(.regular))
                            }
                        }
                        .frame(width: 40, height: 40)
                        .foregroundStyle(selectedIcon == icon ? .linearGradient(colors: [Color(theme.lightBaseColor), Color(theme.darkBaseColor)], startPoint: .top, endPoint: .bottom) :
                                .linearGradient(colors: [Color.primary], startPoint: .top, endPoint: .bottom))
                        .background(.ultraThickMaterial)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedIcon == icon ? .linearGradient(colors: [Color(theme.lightBaseColor), Color(theme.darkBaseColor)], startPoint: .top, endPoint: .bottom) : LinearGradient(colors: [Color.clear], startPoint: .top, endPoint: .bottom), lineWidth: 5)
                        )
                        .cornerRadius(12)
                    }
                }
            }
        }
    }
}
