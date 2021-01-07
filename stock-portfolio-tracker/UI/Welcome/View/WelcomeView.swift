//
//  WelcomeView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/24/20.
//

import SwiftUI
import DICE

struct WelcomeView: View {
    
    @EnvironmentObservableInjected var viewModel: WelcomeViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                GeometryReader { metrics in
                    VStack(alignment: .leading, spacing: metrics.size.height * 0.1) {
                        title.padding([.leading, .trailing], 21)
                        subtitle.padding([.leading, .trailing], 21)
                        startButton.padding([.leading, .trailing], 21)
                    }
                }
            }
        }
    }
    
    var backgroundColor: some View {
        Color(Asset.Colors.primary.color).edgesIgnoringSafeArea(.all)
    }
    
    var title: some View {
        Text(L10n.Common.Label.logo)
            .foregroundColor(Color.white)
            .font(.system(size: 48))
            .fontWeight(.semibold)
    }
    
    var subtitle: some View {
        Text(L10n.Welcome.Label.subtitle)
            .foregroundColor(Color.white)
            .font(.system(size: 22))
            .fontWeight(.light)
    }
    
    var startButton: some View {
        NavigationLink(destination:
                        LoginView()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
        ) {
            Text(L10n.Welcome.Button.Start.title)
        }.buttonStyle(PrimaryButton())
    }
    
}
