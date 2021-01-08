//
//  MainViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import Combine

class MainViewModel: BaseViewModel<MainViewModelInputType, MainViewModelOutputType>, MainViewModelType {
    
    private let authService: AuthServiceType
    
    override init(session: SessionType) {
        self.authService = session.resolve()
        super.init(session: session)
    }
    
    // MARK: - MainViewModelOutputType
    
    @Published var testString: String?
    var testPublisher: Published<String?>.Publisher { $testString }
    
    @Published var selectedTab: Int = 0
    
}

// MARK: - MainViewModelInputType

extension MainViewModel: MainViewModelInputType {
    
    func onViewAppear() {
        
    }
    
    func signOutAction() {
        authService.logout()
    }
    
}

// MARK: - MainViewModelOutputType

extension MainViewModel: MainViewModelOutputType {
    
}
