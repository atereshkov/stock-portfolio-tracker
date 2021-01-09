//
//  LoginViewModelOutput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/25/20.
//

import Foundation

protocol LoginViewModelOutputType {
    var state: LoginViewState { get }
    var routingState: LoginRouting { get }
}
