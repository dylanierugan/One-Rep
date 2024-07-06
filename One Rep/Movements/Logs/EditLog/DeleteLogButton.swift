////
////  DeleteLogButton.swift
////  One Rep
////
////  Created by Dylan Ierugan on 5/23/24.
////
//
//import SwiftUI
//
//struct DeleteLogButton: View {
//    
//    // MARK: - Properties
//    
//    @EnvironmentObject var theme: ThemeModel
//    @Environment(\.dismiss) private var dismiss
//    
//    var deleteLogInRealm: () -> Void
//    
//    // MARK: - View
//    
//    var body: some View {
//        Button {
//            deleteLogInRealm()
//            dismiss()
//        } label: {
//            Text("Delete")
//                .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
//                .foregroundStyle(.linearGradient(colors: [
//                    Color(theme.lightRed),
//                    Color(theme.darkRed)
//                ], startPoint: .top, endPoint: .bottom))
//        }
//    }
//}
