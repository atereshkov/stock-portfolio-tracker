//
//  MainViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import Combine

class MainViewModel: MainViewModelType {
    
    var input: MainViewModelInputType { return self }
    var ouput: MainViewModelOutputType { return self }
    
    init(session: SessionType) {
        
    }
    
}

extension MainViewModel: MainViewModelInputType {
    
    func viewDidLoad() {
        Swift.print("Main View Model onViewDidLoad")
    }
    
}

extension MainViewModel: MainViewModelOutputType {
    var testString: String {
        return "Test"
    }
}
