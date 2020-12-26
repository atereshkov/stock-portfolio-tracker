//
//  PimaryButton.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/26/20.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .foregroundColor(.white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(4)
    }
}
