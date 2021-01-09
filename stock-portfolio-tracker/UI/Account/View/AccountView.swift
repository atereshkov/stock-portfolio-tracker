//
//  AccountView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/9/21.
//

import SwiftUI
import DICE

struct AccountView: View {
    
    @EnvironmentObservableInjected var viewModel: AccountViewModel
    
    var body: some View {
        content
            .onDisappear(perform: viewModel.onDisappear)
    }
    
    var content: some View {
        Text("Account")
    }
    
}
