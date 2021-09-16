//
//  FeesView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import SwiftUI
import DICE

struct FeesView: View {
    
    @EnvironmentObservableInjected var viewModel: FeesViewModel
    
    @State var currencyIndex: Int = 0
    
    var body: some View {
        content
            .sheet(
                isPresented: $viewModel.routingState.showModalSheet,
                content: {
                    modalSheet
                })
    }
    
    var content: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Picker(viewModel.output.feesSign ?? "", selection: $currencyIndex) {
                        ForEach(0..<viewModel.currencyOptions.count) { index in
                            Text(viewModel.currencyOptions[index].name).tag(index)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    Text(viewModel.output.feesValue ?? "")
                }
                .padding(.top, 12)
                dividendsList
            }
            .padding([.leading, .trailing], 18)
            .navigationBarTitle(Text("Fees"), displayMode: .inline)
            .navigationBarItems(trailing: addButton)
        }
    }
    
    var dividendsList: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.fees) { fee in
                    NavigationLink(
                        destination: feeView(fee),
                        tag: fee.id,
                        selection: $viewModel.routingState.feeDetails) {
                        FeeRow(item: fee)
                    }
                }
            }
        }
    }
    
    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .addFee:
            return AnyView(AddFeeView())
        case .none:
            return AnyView(Text(""))
        }
    }
    
    var addButton: some View {
        Button(
            action: viewModel.input.addAction,
            label: { Image(systemName: "plus").imageScale(.large) }
        )
    }
    
    func feeView(_ item: FeeViewItem) -> some View {
//        FeeView(item: item)
        return Text("")
    }
    
}

// MARK: - Preview

#if DEBUG
struct FeesViewPreviews: PreviewProvider {
    static var previews: some View {
        FeesView()
    }
}
#endif
