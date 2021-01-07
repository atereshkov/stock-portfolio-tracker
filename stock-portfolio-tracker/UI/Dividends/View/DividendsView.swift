//
//  DividendsView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/8/21.
//

import SwiftUI
import DICE

struct DividendsView: View {
    
    @EnvironmentObservableInjected var viewModel: HomeViewModel
    
    var body: some View {
        Text("Dividends").padding()
    }
    
}
