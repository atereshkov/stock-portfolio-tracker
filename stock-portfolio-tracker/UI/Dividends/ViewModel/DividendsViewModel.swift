//
//  DividendsViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/8/21.
//

import Combine

class DividendsViewModel: BaseViewModel<DividendsViewModelInputType, DividendsViewModelOutputType>, DividendsViewModelType {
    
    override init(session: SessionType) {
        super.init(session: session)
    }
    
}

// MARK: - DividendsViewModelInputType

extension DividendsViewModel: DividendsViewModelInputType {
    
}

// MARK: - DividendsViewModelOutputType

extension DividendsViewModel: DividendsViewModelOutputType {
    
}
