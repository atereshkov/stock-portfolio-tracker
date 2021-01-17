//
//  AddLotView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import SwiftUI
import DICE

struct AddLotView: View {
    
    @EnvironmentObservableInjected var viewModel: AddLotViewModel
    
    @State var feeCurrencyIndex: Int = 0
    @State var date = Date()
    @State var perShareToggle: Bool = false
    
    init(portfolio: PortfolioViewItem?, holding: HoldingViewItem?) {
        viewModel.portfolio = portfolio
        viewModel.holding = holding
    }
    
    var body: some View {
        content
            .onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
    }
    
    var content: some View {
        NavigationView {
            Form {
                moneySection
                dateSection
                addButtonSection
            }.navigationBarTitle(viewModel.title ?? "", displayMode: .inline)
        }
    }
    
    var moneySection: some View {
        Section {
            HStack {
                TextField("Cost", text: Binding(
                            get: { viewModel.cost ?? "" },
                            set: { viewModel.cost = $0 })
                )
                .keyboardType(.decimalPad)
                Spacer()
                Text(viewModel.portfolio?.currency ?? "")
                    .foregroundColor(Color.gray)
            }
            HStack {
                TextField("Shares", text: Binding(
                            get: { viewModel.shares ?? "" },
                            set: { viewModel.shares = $0 })
                )
                .keyboardType(.numberPad)
            }
            HStack {
                TextField("Fee", text: Binding(
                            get: { viewModel.fee ?? "" },
                            set: { viewModel.fee = $0 })
                )
                .keyboardType(.decimalPad)
                Picker(viewModel.feeCurrencyOptions[feeCurrencyIndex].name, selection: $feeCurrencyIndex) {
                    ForEach(0..<viewModel.feeCurrencyOptions.count) { index in
                        Text(viewModel.feeCurrencyOptions[index].name).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
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
        }
    }
    
    var addButton: some View {
        Section {
            Button(action: {
                viewModel.input.add(currencyIndex: feeCurrencyIndex, date: date)
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
