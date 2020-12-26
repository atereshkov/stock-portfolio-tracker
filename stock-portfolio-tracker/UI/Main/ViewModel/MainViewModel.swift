//
//  MainViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import Combine

class MainViewModel: BaseViewModel<MainViewModelInputType, MainViewModelOutputType>, MainViewModelType {
    
    override init(session: SessionType) {
        super.init(session: session)
    }
    
    // MARK: - MainViewModelOutputType Variables
    
    @Published var testString: String?
    var testPublisher: Published<String?>.Publisher { $testString }
    
}

extension MainViewModel: MainViewModelInputType {
    
    func viewDidLoad() {
        Swift.print("[TEST] Main View Model onViewDidLoad")
        
        testString = "TESTTT"
    }
    
}

// MARK: - MainViewModelOutputType

extension MainViewModel: MainViewModelOutputType {
    
}
