//
//  CreatePortfolioView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/9/21.
//

import SwiftUI
import DICE

struct CreatePortfolioView: View {
    
    @EnvironmentObservableInjected var viewModel: CreatePortfolioViewModel
    
    var body: some View {
        content
            .onDisappear(perform: viewModel.onDisappear)
    }
    
    var content: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: Binding(
                                get: { viewModel.name ?? "" },
                                set: { viewModel.name = $0 })
                    )
                    HStack {
                        Picker("Currency", selection: $viewModel.currency) {
                            Text(viewModel.currencyOptions[0])
                                .tag(viewModel.currencyOptions[0])
                            Text(viewModel.currencyOptions[1])
                                .tag(viewModel.currencyOptions[1])
                        }
                        .pickerStyle(MenuPickerStyle())
                        Spacer()
                        Text(viewModel.input.currency ?? "")
                    }
                }
                Section {
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Create")
                            Spacer()
                        }
                    })
                }
            }.navigationBarTitle(viewModel.title ?? "", displayMode: .inline)
        }
    }
    
}
