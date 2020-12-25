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
    }
    
    var body: some View {
        Text(viewModel.testString)
            .padding()
    }
}
