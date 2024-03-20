//
//  AddMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct AddMovementButton: View {
    
    @State var addMovementClicked = false
    var isFormValid: Bool
    
    var body: some View {
        Button {
            withAnimation {
                addMovementClicked = true
            }
        } label: {
            HStack {
                Text("Add Movement")
                    .foregroundColor(isFormValid ? Color(Color.green): Color.gray)
                    .font(.body.weight(.regular))
                if addMovementClicked {
                    ProgressView()
                        .padding(.leading, 4)
                } else {
                    Image(systemName: Icons.SquareAndPencil.description)
                        .foregroundColor(isFormValid ? Color(.green): Color.gray)
                        .font(.body.weight(.regular))
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(.ultraThickMaterial)
            .cornerRadius(12)
        }
        .disabled(isFormValid ? false : true)
        .disabled(addMovementClicked ? true : false)
    }
}
