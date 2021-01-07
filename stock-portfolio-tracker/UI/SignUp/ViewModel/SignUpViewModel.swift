//
//  SignUpViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/29/20.
//

import Combine
import SwiftUI

class SignUpViewModel: BaseViewModel<SignUpViewModelInputType, SignUpViewModelOutputType>, SignUpViewModelType {
    
    private let authService: AuthServiceType
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        self.authService = session.resolve()
        super.init(session: session)
    }
    
    @Published var email: String?
    @Published var password: String?
    @Published var confirmPassword: String?
    
}

// MARK: - SignUpViewModelInputType

extension SignUpViewModel: SignUpViewModelInputType {
    
    func viewDidLoad() {
        
    }
    
    func signUpAction() {
        guard let email = email?.trim(), let pw = password?.trim() else { return }
        guard !email.isEmpty, !pw.isEmpty else { return }
        
        authService
            .createUser(email: email, password: pw)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    Swift.print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { _ in
                
            })
            .store(in: cancelBag)
    }
    
}

// MARK: - SignUpViewModelOutputType

extension SignUpViewModel: SignUpViewModelOutputType {
    
}
