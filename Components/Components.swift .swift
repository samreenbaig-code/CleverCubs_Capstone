//
//  Components.swift .swift
//  CleverClubs
//
//  Created by Abdulmohammad BAIG on 2025-11-02.
//

import SwiftUI


struct CCTextField: View {
@Binding var text: String
var placeholder: String
var systemImage: String


var body: some View {
HStack(spacing: 10) {
Image(systemName: systemImage)
.foregroundColor(AppTheme.subtleText)
TextField(placeholder, text: $text)
}
.padding(14)
.background(.white.opacity(0.6))
.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
.overlay(
RoundedRectangle(cornerRadius: 16, style: .continuous)
.stroke(AppTheme.subtleText.opacity(0.2), lineWidth: 1)
)
}
}


struct CCPassField: View {
@Binding var text: String
var placeholder: String
@State private var isSecure = true


var body: some View {
HStack(spacing: 10) {
Image(systemName: "lock")
.foregroundColor(AppTheme.subtleText)
Group {
if isSecure {
SecureField(placeholder, text: $text)
} else {
TextField(placeholder, text: $text)
}
}
Button(action: { isSecure.toggle() }) {
Image(systemName: isSecure ? "eye.slash" : "eye")
.foregroundColor(AppTheme.subtleText)
}
}
.padding(14)
.background(.white.opacity(0.6))
.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
.overlay(
RoundedRectangle(cornerRadius: 16, style: .continuous)
.stroke(AppTheme.subtleText.opacity(0.2), lineWidth: 1)
)
}
}
