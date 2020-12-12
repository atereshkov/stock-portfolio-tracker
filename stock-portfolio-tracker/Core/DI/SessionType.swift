//
//  SessionType.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import DICE

protocol SessionType {
    var container: DIContainer { get }
    
    func resolve<T>() -> T
}
