//
//  FacebookLoginView.swift
//  CleverClubs
//
//  Created by Abdulmohammad BAIG on 2025-11-09.
//

import SwiftUI

struct FacebookLoginView: View {
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text("Continue with Facebook")
                    .font(.largeTitle.bold())
                    .foregroundColor(AppTheme.primary)
                
                Text("This is your Facebook sign-in screen.\nYou can integrate Facebook SDK here later.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Image(systemName: "f.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Facebook Login")
        .navigationBarTitleDisplayMode(.inline)
    }
}
