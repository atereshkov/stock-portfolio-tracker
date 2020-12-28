//
//  PrimaryTextField.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/28/20.
//

import SwiftUI

// using divider https://stackoverflow.com/a/60410373/5969121

// swiftlint:disable identifier_name
struct PrimaryTextField: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack {
            configuration
                .colorMultiply(.white)
                .foregroundColor(.white)

            Rectangle()
                .frame(height: 1, alignment: .bottom)
                .foregroundColor(.white)
        }
    }
}
// swiftlint:enable identifier_name
