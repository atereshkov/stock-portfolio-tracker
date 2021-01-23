//
//  AddDividendView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import SwiftUI
import DICE
import Combine

struct AddDividendView: View {
    
    @EnvironmentObservableInjected var viewModel: AddDividendViewModel
    
    @State var portfolioIndex: Int = 0
    @State var tickerIndex: Int = 0
    @State var currencyIndex: Int = 0
    @State var date = Date()
    @State var perShareToggle: Bool = false
    
    var body: some View {
        content
            .onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
    }
    
    var content: some View {
        NavigationView {
            Form {
                tickerSection
                moneySection
                dateSection
            }
            .navigationBarTitle("Add dividends", displayMode: .inline)
            .navigationBarItems(
                leading: cancelButton.padding(.leading, 8),
                trailing: addButtonView.padding(.trailing, 8)
            )
        }
    }
    
    var tickerSection: some View {
        Section {
            HStack {
                TextField("Ticker", text: Binding(
                            get: { viewModel.ticker ?? "" },
                            set: { viewModel.ticker = $0 })
                )
                .keyboardType(.decimalPad)
            }
        }
    }
    
    var moneySection: some View {
        Section {
            HStack {
                Picker("Currency", selection: $currencyIndex) {
                    ForEach(0..<viewModel.currencyOptions.count) { index in
                        Text(viewModel.currencyOptions[index].name).tag(index)
                    }
                }
                .onChange(of: currencyIndex) { [weak viewModel] value in
                    viewModel?.currencyIndex = value
                }
                .pickerStyle(MenuPickerStyle())
                .disabled(viewModel.output.currencySelectionDisabled)
                Spacer()
                Text(viewModel.output.currencyName ?? "")
            }
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
            Toggle(isOn: $perShareToggle) {
                Text("Per 1 share")
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)
            }
            HStack {
                TextField("Tax", text: Binding(
                            get: { viewModel.tax ?? "" },
                            set: { viewModel.tax = $0 })
                )
                .keyboardType(.decimalPad)
                Spacer()
                Text("%")
            }
        }
    }
    
    var dateSection: some View {
        Section {
            DatePicker("Date", selection: $date, displayedComponents: .date)
                .datePickerStyle(DefaultDatePickerStyle())
                .frame(maxHeight: 400)
        }
    }
    
    var addButtonView: some View {
        switch viewModel.output.state {
        case .start:
            return AnyView(addButton)
        case .loading:
            return AnyView(loadingView)
        case .loadingTickers:
            return AnyView(
                addButton.disabled(true)
            )
        }
    }
    
    var addButton: some View {
        Button(action: {
            viewModel.input.add(portfolioIndex: portfolioIndex, tickerIndex: tickerIndex, perShareToggle: perShareToggle, date: date)
        }, label: {
            Text("Add")
        })
    }
    
    var cancelButton: some View {
        Button(action: {
            viewModel.input.cancelAction()
        }, label: {
            Text("Cancel")
        })
    }
    
    var loadingView: some View {
        Section {
            HStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Spacer()
            }
        }
    }
    
}
