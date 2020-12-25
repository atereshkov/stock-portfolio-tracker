//
//  BaseViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/25/20.
//

import Foundation

class BaseViewModel<InputType, OutputType>: ViewModelType {
    
    // swiftlint:disable force_cast
    var input: InputType { return self as! InputType }
    var output: OutputType { return self as! OutputType }
    // swiftlint:enable force_cast
    
}
