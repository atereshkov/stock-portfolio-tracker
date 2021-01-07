//
//  HomeViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/7/21.
//

import Combine

class HomeViewModel: BaseViewModel<HomeViewModelInputType, HomeViewModelOutputType>, HomeViewModelType {
    
    override init(session: SessionType) {
        super.init(session: session)
    }
    
}

// MARK: - HomeViewModelInputType

extension HomeViewModel: HomeViewModelInputType {
    
}

// MARK: - MainViewModelOutputType

extension HomeViewModel: HomeViewModelOutputType {
    
}
