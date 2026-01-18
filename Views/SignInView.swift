//
//  SignInView.swift
//  CleverClubs
//
//  Created by Abdulmohammad BAIG on 2025-11-12.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isSignedIn = false // ✅ Controls navigation to Let's Play screen

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                AppTheme.background.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // MARK: Header
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome\nBack!")
                                .font(.system(size: 30, weight: .heavy))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Image("boy") // Replace with your image asset (optional)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                            .opacity(UIImage(named: "boy") == nil ? 0 : 1)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    
                    // MARK: Input Fields
                    VStack(spacing: 14) {
                        CCTextField(text: $email, placeholder: "Email Address", systemImage: "envelope")
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                        
                        CCPassField(text: $password, placeholder: "Password")
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // MARK: Sign In Button
                    PrimaryButton(title: "Sign In") {
                        signIn()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // MARK: Sign Up Link
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .foregroundColor(.gray)
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .foregroundColor(.blue)
                                .bold()
                        }
                    }
                    .font(.footnote)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // ✅ Hidden Navigation to "Let's Play" Screen after success
                    NavigationLink(destination: LetsPlayView(), isActive: $isSignedIn) {
                        EmptyView()
                    }
                }
            }
            .alert("Oops", isPresented: $showingAlert, actions: {
                Button("OK", role: .cancel) {}
            }, message: {
                Text(alertMessage)
            })
        }
    }

    // MARK: - Sign In Logic
    func signIn() {
        guard email.contains("@") && email.contains(".") else {
            alertMessage = "Please enter a valid email address."
            showingAlert = true
            return
        }
        
        guard !password.isEmpty else {
            alertMessage = "Please enter your password."
            showingAlert = true
            return
        }
        
        // ✅ Simulate successful sign-in
        withAnimation {
            isSignedIn = true
        }
    }
}
