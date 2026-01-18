import SwiftUI

struct ShapeSafariView: View {

    struct ShapeQuestion: Identifiable {
        let id = UUID()
        let imageName: String
        let answer: String
        let prompt: String
    }

    private let questions: [ShapeQuestion] = [
        .init(imageName: "square", answer: "square", prompt: "Sq__a__e"),
        .init(imageName: "star", answer: "star", prompt: "S__ar"),
        .init(imageName: "triangle", answer: "triangle", prompt: "Tr__ang__e"),
        .init(imageName: "circle1", answer: "circle", prompt: "c__rc__e"),
        .init(imageName: "rectangle", answer: "rectangle", prompt: "Re__ta__g__e")
    ]

    @State private var inputs: [UUID: String] = [:]

    var body: some View {
        ZStack {
            Color(red: 0.87, green: 0.86, blue: 1.0).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 14) {
                    header

                    VStack(spacing: 14) {
                        ForEach(questions) { q in
                            row(q)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(spacing: 10) {
            Image("Shape Safari")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)

            Text("Shape")
                .font(.system(size: 22, weight: .bold))

            Text("Fill in the missing letters to name the shape")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 14)
        .padding(.bottom, 8)
    }

    private func row(_ q: ShapeQuestion) -> some View {
        let text = inputs[q.id, default: ""]
        let correct = text.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == q.answer

        return HStack(spacing: 14) {
            Image(q.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)

            Spacer()

            VStack(alignment: .leading, spacing: 8) {
                Text(q.prompt)
                    .font(.system(size: 28, weight: .medium))

                HStack(spacing: 8) {
                    TextField("Type: \(q.answer)", text: Binding(
                        get: { inputs[q.id, default: ""] },
                        set: { inputs[q.id] = $0 }
                    ))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color.white.opacity(0.35))
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(borderColor(text: text, isCorrect: correct), lineWidth: 2)
                    )

                    if !text.isEmpty {
                        Image(systemName: correct ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(correct ? .green : .red)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
            }
            .frame(maxWidth: 220, alignment: .leading)
        }
        .padding(14)
        .background(Color.white.opacity(0.10))
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black.opacity(0.08), lineWidth: 1)
        )
    }

    private func borderColor(text: String, isCorrect: Bool) -> Color {
        if text.isEmpty { return .gray.opacity(0.35) }
        return isCorrect ? .green : .red
    }
}

#Preview {
    NavigationStack { ShapeSafariView() }
}
