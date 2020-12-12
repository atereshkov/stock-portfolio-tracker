//
//  DICE+SwiftUI.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/7/20.
//  Copyright © 2020 DICE. All rights reserved.
//

#if canImport(SwiftUI) && canImport(Combine)

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    
    /// Set dependency container to view
    func inject(container: DIContainer) -> some View {
        self.environment(\.container, container)
    }
    
    // Inject property into container
    func environmentInject<Value>(_ value: Value) -> some View {
        return self.transformEnvironment(\.container) { container in
            container.register() { _ in value }
        }
    }
    
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {
    var container: DIContainer {
        get { self[DIContainerEnvironmentKey.self] }
        set { self[DIContainerEnvironmentKey.self] = newValue }
    }
}

#endif
