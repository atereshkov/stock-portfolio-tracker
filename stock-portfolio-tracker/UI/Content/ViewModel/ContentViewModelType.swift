//
//  ContentViewModelType.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import Combine

protocol ContentViewModelType: ObservableObject {
    var session: SessionType { get }
    
    var testString: String { get }
}
