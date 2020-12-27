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
                GeometryReader { metrics in
                    VStack(alignment: .leading, spacing: metrics.size.height * 0.15) {
                        logo.padding([.leading, .trailing], 21)
                    }
                }
            }
        }
    }
    
    var logo: some View {
        Text("Stock\nPortfolio\nTracker")
            .foregroundColor(Color.white)
            .font(.system(size: 36))
            .fontWeight(.semibold)
    }
    
    var backgroundColor: some View {
        Color(Asset.Colors.primary.color).edgesIgnoringSafeArea(.all)
    }
}
