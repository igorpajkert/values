//
//  ValueCard.swift
//  Values
//
//  Created by Igor Pajkert on 07/06/2025.
//

import SwiftUI

struct ValueCard: View {
    
    @Environment(\.colorScheme) private var scheme
    
    let name: String
    var index: Int
    var isSelected: Bool
    let action: () -> Void
    
    private var textColor: Color {
        isSelected ? .lavender.adaptedTextColor() : .lightLavender.adaptedTextColor()
    }
    
    private var backgroundColor: Color {
        isSelected ? .lavender : .lightLavender
    }
    
    private var borderColor: Color {
        isSelected ? .lavender : Color.accent
    }
    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 32)
                .stroke(borderColor, lineWidth: 4)
                .fill(backgroundColor)
                .frame(height: 100)
                .overlay {
                    Text(name)
                        .foregroundStyle(textColor)
                    if isSelected {
                        Text(index, format: .number)
                            .foregroundStyle(.white)
                            .padding(10)
                            .background {
                                Circle()
                                    .fill(.accent)
                            }
                            .offset(y: 30)
                            .shadow(radius: 4)
                    }
                }
        }
    }
}

#Preview("Selected") {
    ValueCard(name: "Test", index: 0, isSelected: true, action: {})
    ValueCard(name: "Test", index: 10, isSelected: false, action: {})
}
