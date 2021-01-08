//
//  HomeView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/7/21.
//

import SwiftUI
import DICE

struct HomeView: View {
    
    @EnvironmentObservableInjected var viewModel: HomeViewModel
    
    var body: some View {
        content
    }
    
    var content: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        Text("Hello World")
                        Text("Hello World")
                    }
                }
            }
            .navigationBarTitle(Text("Dashboard"))
        }
    }
    
}
