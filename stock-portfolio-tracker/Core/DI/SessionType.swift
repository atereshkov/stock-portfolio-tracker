//
//  SessionType.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

protocol SessionType {
    var appState: Store<AppState> { get }
    
    func resolve<T>() -> T
}
