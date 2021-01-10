//
//  AddDividendViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation

protocol AddDividendViewModelInputType {
    func add()
    
    func onDisappear()
    
    var paid: String? { get set }
    var tax: String? { get set }
}
