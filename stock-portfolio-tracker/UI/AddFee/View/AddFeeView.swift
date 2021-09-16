//
//  AddFeeView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import SwiftUI
import DICE
import Combine

struct AddFeeView: View {
    
    @EnvironmentObservableInjected var viewModel: AddFeeViewModel
    
    @State var typeIndex: Int = 0
    @State var portfolioIndex: Int = 0
    @State var tickerIndex: Int = 0
    @State var currencyIndex: Int = 0
    @State var date = Date()
    
    var body: some View {
        content
            .onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
    }
    
    var content: some View {
        NavigationView {
            Form {
                typeSection
                if viewModel.showPortfolio {
                    portfolioSection
                }
                moneySection
                dateSection
                addButtonSection
            }.navigationBarTitle("Add fee", displayMode: .inline)
        }
    }
    
    var typeSection: some View {
        Section {
            HStack {
                Picker("Type", selection: $typeIndex) {
                    ForEach(0..<viewModel.typeOptions.count) { index in
                        Text(viewModel.typeOptions[index].localizedType()).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: typeIndex) { [weak viewModel] value in
                    viewModel?.typeIndex = value
                }
                Spacer()
                Text(viewModel.typeOptions[typeIndex].localizedType())
            }
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
                TextField("Paid", text: Binding(
                            get: { viewModel.paid ?? "" },
                            set: { viewModel.paid = $0 })
                )
                .keyboardType(.decimalPad)
                Spacer()
                Picker(viewModel.currencyOptions[currencyIndex].name, selection: $currencyIndex) {
                    ForEach(0..<viewModel.currencyOptions.count) { index in
                        Text(viewModel.currencyOptions[index].name).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
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
                viewModel.input.add(portfolioIndex: portfolioIndex, tickerIndex: tickerIndex, currencyIndex: currencyIndex, date: date)
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
