//
//  ContentView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import SwiftUI
import DICE

struct ContentView: View {
    
    @EnvironmentObservableInjected var viewModel: ContentViewModel
    
    var body: some View {
        Text(viewModel.testString)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
