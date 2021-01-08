//
//  RootViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/8/21.
//

import SwiftUI
import Combine

class RootViewModel: ObservableObject {
    
    @Published var routingState: RootRouting
    @Published var isAuthorized: Bool = true
    
    let session: SessionType
    let cancelBag = CancelBag()
    
    init(session: SessionType) {
        self.session = session
        
        _routingState = .init(initialValue: session.appState.value.routing.root)
        
        // TODO check local auth service/etc to and set isAuthorized to improve UX
        
        session.appState.map(\.auth.isAuthorized)
            .removeDuplicates()
            .assign(to: \.isAuthorized, on: self)
            .store(in: cancelBag)
    }
    
}
