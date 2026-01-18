//
//  GoogleLoginView.swift
//  CleverClubs
//
//  Created by Abdulmohammad BAIG on 2025-11-09.
//

import SwiftUI

struct GoogleLoginView: View {
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text("Continue with Google")
                    .font(.largeTitle.bold())
                    .foregroundColor(.red)
                
                Text("This page will handle Google Sign-In integration.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Image(systemName: "g.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Google Login")
        .navigationBarTitleDisplayMode(.inline)
    }
}

