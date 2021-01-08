//
//  RootView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/8/21.
//

import SwiftUI
import DICE

struct RootView: View {
    
    @EnvironmentObservableInjected var viewModel: RootViewModel
    
    var body: some View {
        if viewModel.output.isAuthorized {
            MainView()
        } else {
            WelcomeView()
        }
    }
    
}
