//
//  DIContainerEnvironmentKey.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/7/20.
//  Copyright © 2020 DICE. All rights reserved.
//

#if canImport(SwiftUI) && canImport(Combine)

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct DIContainerEnvironmentKey: EnvironmentKey {
    static var defaultValue: DIContainer = DICE.sharedContainer
}

#endif
