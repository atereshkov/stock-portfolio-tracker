//
//  PimaryButton.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/26/20.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    
    let disabled: Bool
    
    init() {
        disabled = false
    }
    
    init(disabled: Bool) {
        self.disabled = disabled
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold))
            .background(disabled ? .gray : Color(Asset.Colors.primaryLight.color))
            .cornerRadius(4)
            .shadow(color: Color.black.opacity(0.05), radius: 7, x: 0, y: 6)
            .disabled(disabled)
    }
}
