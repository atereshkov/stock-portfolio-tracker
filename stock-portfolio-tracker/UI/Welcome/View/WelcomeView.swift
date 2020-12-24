//
//  WelcomeView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/24/20.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                startButton
            }
        }
    }
    
    var startButton: some View {
        NavigationLink(destination:
                        MainView()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
        ) {
            Text("Let's start")
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
