//
//  CircleLoadingView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/7/21.
//

import SwiftUI

struct CircleLoadingView: View {
    
    var color: Color
    
    @State private var shouldAnimate = false
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 14, height: 14)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever())
            Circle()
                .fill(color)
                .frame(width: 14, height: 14)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3))
            Circle()
                .fill(color)
                .frame(width: 14, height: 14)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6))
        }
        .onAppear {
            self.shouldAnimate = true
        }
    }
    
}
