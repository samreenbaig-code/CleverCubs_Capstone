//
//  Theme.swift
//  CleverClubs
//
//  Created by Abdulmohammad BAIG on 2025-11-02.
//

import SwiftUI

struct AppTheme {
    // Colors
    static let background = Color(hex: "#D7D6FB") // light purple background
    static let primary = Color(hex: "#5B2D82")    // deep purple
    static let accent = Color(hex: "#8BC34A")     // green for buttons
    static let subtleText = Color.black.opacity(0.65)

    // Text Styles
    static func title(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 32, weight: .bold))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
    }

    static func subtitle(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(subtleText)
            .multilineTextAlignment(.center)
    }
}

// Allow hex color initialization
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}
struct OutlineButton: View {
    var title: String
    var systemImage: String? = nil
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(AppTheme.subtleText.opacity(0.25), lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.white.opacity(0.6))
                    )
            )
            .foregroundColor(.black)
        }
        .buttonStyle(.plain)
    }
}

struct PrimaryButton: View {
    var title: String
    var systemImage: String? = nil
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(AppTheme.accent)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
        }
        .buttonStyle(.plain)
    }
}

