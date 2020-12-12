//
//  Weak.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/6/20.
//

class WeakObject<T: AnyObject>: CustomDebugStringConvertible {
    
    weak var value: T?
    
    init(value: T) {
        self.value = value
    }
    
    var debugDescription: String {
        let address = Unmanaged.passUnretained(self).toOpaque()
        let type = String(describing: T.self)
        return String(format: "<Weak<%@>>: %@, value: %@", type, address.debugDescription, value.debugDescription)
    }
    
}
