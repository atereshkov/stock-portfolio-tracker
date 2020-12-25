//
//  WelcomeViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/24/20.
//

import Combine

class WelcomeViewModel: BaseViewModel<WelcomeViewModelInputType, WelcomeViewModelOutputType>, WelcomeViewModelType {
    
    override init(session: SessionType) {
        super.init(session: session)
    }
    
}

extension WelcomeViewModel: WelcomeViewModelInputType {
    
    func startButtonAction() {
        
    }
    
}

extension WelcomeViewModel: WelcomeViewModelOutputType { }
