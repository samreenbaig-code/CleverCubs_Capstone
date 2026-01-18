//
//  WelcomeView.swift
//  CleverClubs
//
//  Created by Abdulmohammad BAIG on 2025-11-02.
//

import SwiftUI


struct WelcomeView: View {
var body: some View {
ZStack {
AppTheme.background.ignoresSafeArea()
VStack(spacing: 16) {
Spacer()
// Replace with asset name: "welcome_kids"
Image("welcome")
.resizable()
.scaledToFit()
.frame(maxWidth: 420)
.overlay(
Group {
if UIImage(named: "welcome") == nil {
RoundedRectangle(cornerRadius: 24)
.fill(.white.opacity(0.5))
.frame(height: 260)
.overlay(AppTheme.title("Welcome!"))
}
}
)
Spacer()
NavigationLink {
GetStartedView()
} label: {
Image(systemName: "arrow.right.circle.fill")
.font(.system(size: 44, weight: .bold))
.foregroundColor(.black)
.padding(.bottom, 40)
}
}
.padding(.horizontal, 24)
}
}
}
