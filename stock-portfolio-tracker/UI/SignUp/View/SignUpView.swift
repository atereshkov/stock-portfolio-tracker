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
                    VStack(alignment: .leading) {
                        logo.padding([.leading, .trailing], 21)
                        content.padding(.top, metrics.size.height * 0.07)
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
                .padding([.top], 18)
            confirmPasswordTextField
                .padding([.leading, .trailing], 21)
                .padding([.top], 18)
            signUpButton
                .padding([.leading, .trailing], 21)
                .padding([.top], 18)
            dontWantToSignUpButton
                .padding([.leading, .trailing], 21)
                .padding([.top], 9)
            alreadyHaveAccountLabel
                .padding()
                .padding([.top], 18)
        }
    }
    
    var emailTextField: some View {
        TextField("", text: Binding(
                    get: { viewModel.email ?? "" },
                    set: { viewModel.email = $0 })
        )
        .textFieldStyle(PrimaryTextField())
        .keyboardType(.emailAddress)
        .disableAutocorrection(true)
        .placeHolder(Text("E-mail"), show: viewModel.email?.isEmpty ?? true)
    }
    
    var passwordTextField: some View {
        SecureField("", text: Binding(
                    get: { viewModel.password ?? "" },
                    set: { viewModel.password = $0 })
        )
        .textFieldStyle(PrimaryTextField())
        .disableAutocorrection(true)
        .placeHolder(Text("Password"), show: viewModel.password?.isEmpty ?? true)
    }
    
    var confirmPasswordTextField: some View {
        SecureField("", text: Binding(
                    get: { viewModel.confirmPassword ?? "" },
                    set: { viewModel.confirmPassword = $0 })
        )
        .textFieldStyle(PrimaryTextField())
        .disableAutocorrection(true)
        .placeHolder(Text("Confirm password"), show: viewModel.confirmPassword?.isEmpty ?? true)
    }
    
    var signUpButton: some View {
        Button("Sign Up") {
            viewModel.input.signUpAction()
        }.buttonStyle(PrimaryButton())
    }
    
    var dontWantToSignUpButton: some View {
        Button("I don't want to sign up") {
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundColor(.white)
        .font(.system(size: 16, weight: .semibold))
        .background(Color.clear)
        .shadow(color: Color.black.opacity(0.05), radius: 7, x: 0, y: 6)
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.white, lineWidth: 1))
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
