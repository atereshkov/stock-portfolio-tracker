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
                    VStack(alignment: .leading, spacing: metrics.size.height * 0.25) {
                        title.padding(.leading, 21)
                        subtitle.padding(.leading, 21)
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
        Text("Stock\nPortfolio\nTracker")
            .foregroundColor(Color.white)
    }
    
    var subtitle: some View {
        Text("Track your investments and dividends. Simple and easy.")
            .foregroundColor(Color.white)
    }
    
    var startButton: some View {
        NavigationLink(destination:
                        LoginView()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
        ) {
            Text(L10n.Welcome.Button.Start.title)
        }
        // .navigationViewStyle(StackNavigationViewStyle())
    }
    
}
