//
//  TransactionsViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Combine

class TransactionsViewModel: BaseViewModel<TransactionsViewModelInputType, TransactionsViewModelOutputType>, TransactionsViewModelType {
    
    override init(session: SessionType) {
        super.init(session: session)
    }
    
}

// MARK: - TransactionsViewModelInputType

extension TransactionsViewModel: TransactionsViewModelInputType {
    
}

// MARK: - TransactionsViewModelOutputType

extension TransactionsViewModel: TransactionsViewModelOutputType {
    
}
