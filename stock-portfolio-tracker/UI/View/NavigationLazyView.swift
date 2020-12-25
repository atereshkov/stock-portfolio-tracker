//
//  NavigationLazyView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/25/20.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
