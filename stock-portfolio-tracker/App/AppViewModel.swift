//
//  AppViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/7/21.
//

import SwiftUI
import Combine

class AppViewModel: ObservableObject {
    
    @Published var routingState: RootRouting
    @Published var isAuthorized: Bool = false
    
    let session: SessionType
    
    private var cancelBag = CancelBag()
    
    init(session: SessionType) {
        self.session = session
        
        _routingState = .init(initialValue: session.appState.value.routing.root)
        
        session.appState.map(\.userData.isAuthorized)
            .removeDuplicates()
            .assign(to: \.isAuthorized, on: self)
            .store(in: cancelBag)
    }
    
}
