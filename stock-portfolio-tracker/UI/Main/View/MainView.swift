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
        Text(viewModel.output.testString ?? "")
            .padding()
    }
}
