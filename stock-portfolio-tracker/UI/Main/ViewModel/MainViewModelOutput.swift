//
//  MainViewModelOutput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/24/20.
//

import Foundation

protocol MainViewModelOutputType {
    var testString: String? { get }
    var testPublisher: Published<String?>.Publisher { get }
}
