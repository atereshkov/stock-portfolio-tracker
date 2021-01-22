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
                portfolioSection
                moneySection
                dateSection
                addButtonSection
            }.navigationBarTitle("Add dividends", displayMode: .inline)
        }
    }
    
    var portfolioSection: some View {
        Section {
            HStack {
                Picker("Portfolio", selection: $portfolioIndex) {
                    ForEach(0..<viewModel.portfolioOptions.count) { index in
                        Text(viewModel.portfolioOptions[index].name).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: portfolioIndex) { [weak viewModel] value in
                    viewModel?.portfolioIndex = value
                }
                Spacer()
                Text(viewModel.portfolioOptions[portfolioIndex].name)
            }
            switch viewModel.output.state {
            case .loadingTickers:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            default:
                tickerPicker
            }
        }
    }
    
    var tickerPicker: some View {
        HStack {
            Picker("Ticker", selection: $tickerIndex) {
                ForEach(0..<viewModel.tickerOptions.count, id: \.self) { index in
                    Text(viewModel.selectedTicker(index)?.ticker ?? "").tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            Spacer()
            Text(viewModel.selectedTicker(tickerIndex)?.ticker ?? "")
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
                .pickerStyle(MenuPickerStyle())
                Spacer()
                Text(viewModel.currencyOptions[currencyIndex].name)
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
    
    var addButtonSection: some View {
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
        Section {
            Button(action: {
                viewModel.input.add(portfolioIndex: portfolioIndex, tickerIndex: tickerIndex, currencyIndex: currencyIndex, perShareToggle: perShareToggle, date: date)
            }, label: {
                HStack {
                    Spacer()
                    Text("Add")
                    Spacer()
                }
            })
        }
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
