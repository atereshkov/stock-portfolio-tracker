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
    
    @State var currencyIndex: Int = 0
    
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
                        Picker("Currency", selection: $currencyIndex) {
                            ForEach(0..<viewModel.currencyOptions.count) { index in
                                Text(viewModel.currencyOptions[index].name).tag(index)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        Spacer()
                        Text(viewModel.currencyOptions[currencyIndex].name)
                    }
                }
                Section {
                    Button(action: {
                        viewModel.create(currencyIndex: currencyIndex)
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
