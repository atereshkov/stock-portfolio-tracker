//
//  SignUpView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/29/20.
//

import SwiftUI
import DICE

struct SignUpView: View {
    
    @EnvironmentObservableInjected var viewModel: SignUpViewModel
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                GeometryReader { metrics in
                    VStack(alignment: .leading, spacing: metrics.size.height * 0.15) {
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
            passwordTextField.padding([.leading, .trailing], 21)
            confirmPasswordTextField.padding([.leading, .trailing], 21)
            signUpButton.padding([.leading, .trailing], 21)
            dontWantToSignUpButton.padding([.leading, .trailing], 21)
            alreadyHaveAccountLabel.padding()
        }
    }
    
    var emailTextField: some View {
        TextField("E-mail", text: Binding(
                    get: { viewModel.email },
                    set: { viewModel.email = $0 })
        ).textFieldStyle(PrimaryTextField())
    }
    
    var passwordTextField: some View {
        SecureField("Password", text: Binding(
                    get: { viewModel.password },
                    set: { viewModel.password = $0 })
        ).textFieldStyle(PrimaryTextField())
    }
    
    var confirmPasswordTextField: some View {
        SecureField("Confirm password", text: Binding(
                    get: { viewModel.confirmPassword },
                    set: { viewModel.confirmPassword = $0 })
        ).textFieldStyle(PrimaryTextField())
    }
    
    var signUpButton: some View {
        Button("Sign Up") {
            viewModel.input.signUpAction()
        }
    }
    
    var dontWantToSignUpButton: some View {
        Button("I don't want to sign up") {
            
        }
    }
    
    var alreadyHaveAccountLabel: some View {
        Text("I already have an account")
            .foregroundColor(Color.white)
            .underline()
            .onTapGesture {
                presentation.wrappedValue.dismiss()
            }
    }
    
    var backgroundColor: some View {
        Color(Asset.Colors.primary.color).edgesIgnoringSafeArea(.all)
    }
    
}
