//
//  MainViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/24/20.
//

import Foundation

protocol MainViewModelInputType {
    var selectedTab: Int { get set }
    
    func viewDidLoad()
    
    func signOutAction()
}
