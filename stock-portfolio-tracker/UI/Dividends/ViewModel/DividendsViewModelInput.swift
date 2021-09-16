//
//  DividendsViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/8/21.
//

import Foundation

protocol DividendsViewModelInputType {
    func addAction()
    
    func onAppear()
    func onRowAppear(item: DividendViewItem)
}
