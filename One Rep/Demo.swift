//
//  Home.swift
//  GlassMorphismNew
//
//  Created by Dylan Ierugan on 4/4/24
//

import Combine
import SwiftUI

struct Demo: View {
    
    @State var selectedDate: Weekdays = .Mon
    
    var body: some View {
        HStack {
            Button {
            } label: {
                Image(systemName: Icons.ChevronLeft.description)
                    .font(.title2).bold()
                    .foregroundStyle(.black)
            }
            ForEach(Weekdays.allCases, id: \.rawValue) { day in
                Button(action: {
                    selectedDate = day
                }, label: {
                    VStack {
                        Text("16")
                            .foregroundStyle(selectedDate == day ? Color(.primary) : .secondary)
                            .customFont(size: .callout, weight: .semibold, kerning: 0, design: .rounded)
                            .frame(maxWidth: .infinity)
                        Text(day.rawValue)
                            .foregroundStyle(selectedDate == day ? Color(.primary) : .secondary)
                            .customFont(size: .callout, weight: .semibold, kerning: 0, design: .rounded)
                            .frame(maxWidth: .infinity)
                    }
                })
            }
            Button {
            } label: {
                Image(systemName: Icons.ChevronRight.description)
                    .font(.title2).bold()
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal, 16)
    }
}



#Preview {
    Demo()
}
