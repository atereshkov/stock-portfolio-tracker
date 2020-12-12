//
//  ContentViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import Combine

class ContentViewModel: ContentViewModelType {
    
    let session: SessionType
    
    init(session: SessionType) {
        self.session = session
    }
    
    var testString: String {
        return "Test"
    }
    
}
