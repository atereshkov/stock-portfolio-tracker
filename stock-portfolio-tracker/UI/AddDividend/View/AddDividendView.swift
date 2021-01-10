//
//  AddDividendView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import SwiftUI
import DICE

struct AddDividendView: View {
    
    @EnvironmentObservableInjected var viewModel: AddDividendViewModel
    
    @State var portfolioIndex: Int = 0
    @State var tickerIndex: Int = 0
    
    @State var date = Date()
    
    @State var perShareToggle: Bool = false
    
    var body: some View {
        content
            .onDisappear(perform: viewModel.onDisappear)
    }
    
    var content: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Picker("Portfolio", selection: $portfolioIndex) {
                            ForEach(0..<viewModel.portfolioOptions.count) { index in
                                Text(viewModel.portfolioOptions[index].name).tag(index)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        Spacer()
                        Text(viewModel.portfolioOptions[portfolioIndex].name)
                    }
                    HStack {
                        Picker("Ticker", selection: $tickerIndex) {
                            ForEach(0..<viewModel.tickerOptions.count) { index in
                                Text(viewModel.tickerOptions[index].ticker).tag(index)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        Spacer()
                        Text(viewModel.tickerOptions[tickerIndex].ticker)
                    }
                }
                Section {
                    HStack {
                        TextField("Paid", text: Binding(
                                    get: { viewModel.paid ?? "" },
                                    set: { viewModel.paid = $0 })
                        )
                        .keyboardType(.decimalPad)
                        if perShareToggle {
                            Spacer()
                            Text("per share")
                                .font(.system(size: 12))
                                .foregroundColor(Color.gray)
                        }
                    }
                    HStack {
                        TextField("Tax", text: Binding(
                                    get: { viewModel.tax ?? "" },
                                    set: { viewModel.tax = $0 })
                        )
                        .keyboardType(.numberPad)
                        Spacer()
                        Text("%")
                    }
                    Toggle(isOn: $perShareToggle) {
                        Text("Per 1 share")
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                    }
                }
                Section {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(DefaultDatePickerStyle())
                        .frame(maxHeight: 400)
                }
                Section {
                    Button(action: {
                        viewModel.input.add(portfolioIndex: portfolioIndex, tickerIndex: tickerIndex, perShareToggle: perShareToggle, date: date)
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Add")
                            Spacer()
                        }
                    })
                }
            }.navigationBarTitle("Add dividends", displayMode: .inline)
        }
    }
    
}
