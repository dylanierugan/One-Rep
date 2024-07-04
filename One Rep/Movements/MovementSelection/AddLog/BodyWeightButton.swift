////
////  BodyWeightButton.swift
////  One Rep
////
////  Created by Dylan Ierugan on 4/9/24.
////
//
//import SwiftUI
//
//struct BodyWeightButton: View {
//    
//    // MARK: - Properties
//    
//    @EnvironmentObject var theme: ThemeModel
//    
//    @Binding var isBodyWeightSelected: Bool
//    
//    // MARK: - View
//    
//    var body: some View {
//        Button {
//            withAnimation {
//                isBodyWeightSelected.toggle()
//            }
//        } label: {
//            ZStack {
//                Rectangle()
//                    .cornerRadius(16)
//                    .foregroundColor(isBodyWeightSelected ? Color(theme.darkBlue).opacity(0.05) : .secondary.opacity(0.05))
//                    .frame(width: 40, height: 36)
//                
//                HStack {
//                    Image(systemName: "figure.stand")
//                }
//                .customFont(size: .caption, weight: .medium, kerning: 0, design: .rounded)
//                .foregroundColor(isBodyWeightSelected ? Color(theme.darkBlue) : .secondary)
//            }
//        }
//    }
//}
