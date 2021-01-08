//
//  MainView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import SwiftUI
import DICE

struct MainView: View {
    
    @EnvironmentObservableInjected var viewModel: MainViewModel
    
    init() {
        viewModel.input.viewDidLoad()
        
        _ = viewModel.output.testPublisher.sink { value in
            Swift.print("[TEST] Value: \(String(describing: value))")
        }
    }
    
    var body: some View {
        content
//        NavigationView {
//            ZStack {
//                backgroundColor
//                GeometryReader { metrics in
//                    VStack(alignment: .leading, spacing: metrics.size.height * 0.1) {
//                        Text(viewModel.output.testString ?? "")
//                            .padding()
//                        Button("Sign Out") {
//                            viewModel.input.signOutAction()
//                        }.buttonStyle(PrimaryButton())
//                    }
//                }
//            }
//        }
    }
    
    var content: some View {
        TabView(selection: $viewModel.selectedTab) {
            HomeView()
                .tabItem {
                    viewModel.selectedTab == 0 ? Image(systemName: "house.fill") : Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            DividendsView()
                .tabItem {
                    viewModel.selectedTab == 1 ? Image(systemName: "chart.bar.fill") : Image(systemName: "chart.bar")
                    Text("Dividends")
                }
                .tag(1)
        }
    }
    
    var backgroundColor: some View {
        Color(Asset.Colors.primary.color).edgesIgnoringSafeArea(.all)
    }
    
}
