//
//  LoginView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/25/20.
//

import SwiftUI
import DICE

struct LoginView: View {
    
    @EnvironmentObservableInjected var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                VStack {
                    
                }
            }
        }
    }
    
    var backgroundColor: some View {
        Color(Asset.Colors.primary.color).edgesIgnoringSafeArea(.all)
    }
}
