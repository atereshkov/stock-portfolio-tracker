//
//  LoginView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/25/20.
//

import SwiftUI
import DICE

struct LoginView: View {
    
    @EnvironmentObservableInjected var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                GeometryReader { metrics in
                    VStack(alignment: .leading, spacing: metrics.size.height * 0.1) {
                        logo.padding([.leading, .trailing], 21)
                        content
                    }
                }
            }
        }
    }
    
    var logo: some View {
        Text(L10n.Common.Label.logo)
            .foregroundColor(Color.white)
            .font(.system(size: 36))
            .fontWeight(.semibold)
    }
    
    var content: some View {
        VStack {
            emailTextField.padding([.leading, .trailing], 21)
            passwordTextField
                .padding([.leading, .trailing], 21)
                .padding([.top], 24)
            signInButton
                .padding([.leading, .trailing], 21)
                .padding([.top], 24)
            dontHaveAccountLabel.padding()
        }
    }
    
    var emailTextField: some View {
        TextField("", text: Binding(
                    get: { viewModel.email },
                    set: { viewModel.email = $0 })
        )
        .textFieldStyle(PrimaryTextField())
        .placeHolder(Text("E-mail"), show: viewModel.email.isEmpty)
    }
    
    var passwordTextField: some View {
        SecureField("", text: Binding(
                    get: { viewModel.password },
                    set: { viewModel.password = $0 })
        )
        .textFieldStyle(PrimaryTextField())
        .placeHolder(Text("Password"), show: viewModel.password.isEmpty)
    }
    
    var signInButton: some View {
        Button("Sign In") {
            viewModel.input.signInAction()
        }.buttonStyle(PrimaryButton())
    }
    
    var dontHaveAccountLabel: some View {
        NavigationLink(destination:
                        SignUpView()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
        ) {
            Text("I don't have an account")
                .foregroundColor(Color.white)
                .underline()
        }
    }
    
    var backgroundColor: some View {
        Color(Asset.Colors.primary.color).edgesIgnoringSafeArea(.all)
    }
}
