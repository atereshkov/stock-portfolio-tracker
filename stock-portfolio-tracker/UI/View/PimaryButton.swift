//
//  PimaryButton.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/26/20.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background(Color(Asset.Colors.primaryLight.color))
            .cornerRadius(4)
            .shadow(color: Color.black.opacity(0.05), radius: 7, x: 0, y: 6)
    }
}
