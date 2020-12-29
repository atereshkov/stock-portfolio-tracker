//
//  SignUpViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/29/20.
//

import Combine

class SignUpViewModel: BaseViewModel<SignUpViewModelInputType, SignUpViewModelOutputType>, SignUpViewModelType {
    
    override init(session: SessionType) {
        super.init(session: session)
    }
    
}

// MARK: - SignUpViewModelInputType

extension SignUpViewModel: SignUpViewModelInputType {
    
    func viewDidLoad() {
        
    }
    
}

// MARK: - SignUpViewModelOutputType

extension SignUpViewModel: SignUpViewModelOutputType {
    
}
