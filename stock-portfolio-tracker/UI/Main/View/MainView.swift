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
    
    var body: some View {
        content
            .onAppear {
                viewModel.input.onViewAppear()
            }
    }
    
    var content: some View {
        TabView(selection: $viewModel.selectedTab) {
            homeTab
            dividendsTab
        }
    }
    
    var homeTab: some View {
        HomeView()
            .tabItem {
                viewModel.selectedTab == 0 ? Image(systemName: "house.fill") : Image(systemName: "house")
                Text("Home")
            }
            .tag(0)
    }
    
    var dividendsTab: some View {
        DividendsView()
            .tabItem {
                viewModel.selectedTab == 1 ? Image(systemName: "chart.bar.fill") : Image(systemName: "chart.bar")
                Text("Dividends")
            }
            .tag(1)
    }
    
    var backgroundColor: some View {
        Color(Asset.Colors.primary.color).edgesIgnoringSafeArea(.all)
    }
    
}
