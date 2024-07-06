////
////  LogBodyweightSection.swift
////  One Rep
////
////  Created by Dylan Ierugan on 6/15/24.
////
//
//import SwiftUI
//import RealmSwift
//
//struct LogBodyweightSection: View {
//    
//    // MARK: - Properties
//    
//    @EnvironmentObject var theme: ThemeModel
//    @EnvironmentObject var logViewModel: LogViewModel
//    
//    @ObservedRealmObject var userModel: UserModel
//    @ObservedRealmObject var movement: Movement
//    
//    @Binding var addWeightToBodyWeight: Bool
//    
//    @FocusState var isInputActive: Bool
//    
//    var addLogToRealm:() -> Void
//    
//    // MARK: - View
//    
//    var body: some View {
//        HStack {
//            Spacer()
//            VStack(spacing: 16) {
//                if addWeightToBodyWeight {
//                    VStack(spacing: 16) {
//                        HStack {
//                            Spacer()
//                            BodyweightView(userModel: userModel)
//                                .frame(width: 148)
//                            Spacer()
//                            MutateRepsView()
//                            Spacer()
//                        }
//                        MutateWeightView(movement: movement)
//                    }
//                } else {
//                    HStack {
//                        Spacer()
//                        BodyweightView(userModel: userModel)
//                            .frame(width: 148)
//                        Spacer()
//                        MutateRepsView()
//                        Spacer()
//                    }
//                }
//                
//                Button {
//                    withAnimation {
//                        addWeightToBodyWeight.toggle()
//                    }
//                } label: {
//                    Text(addWeightToBodyWeight ? "Remove weight" : "Add weight")
//                        .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
//                        .foregroundColor(.secondary).opacity(0.5)
//                }
//                
//                LogSetButton(movement: movement, addLogToRealm: addLogToRealm)
//                    .padding(.top, 8)
//            }
//            Spacer()
//        }
//        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
//        .padding(.vertical, 24)
//        .background(Color(theme.backgroundElementColor))
//    }
//}
//
