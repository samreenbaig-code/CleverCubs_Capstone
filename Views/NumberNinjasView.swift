import SwiftUI

struct NumberNinjasView: View {

    // MARK: - Model
    struct Question: Identifiable {
        let id = UUID()
        let imageName: String
        let count: Int
    }

    // MARK: - Data (edit image names if needed)
    private let questions: [Question] = [
        Question(imageName: "Cat", count: 1),
        Question(imageName: "Chick", count: 4),
        Question(imageName: "Elephant", count: 7),
        Question(imageName: "Ball", count: 3),
        Question(imageName: "Apple", count: 5)
    ]

    // MARK: - State
    @State private var answers: [UUID: String] = [:]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                header

                // Questions
                ForEach(questions) { q in
                    questionCard(q)
                }

                Spacer(minLength: 18)
            }
            .padding(.horizontal, 16)   // ✅ prevents cutting on iPhone SE
            .padding(.bottom, 24)
        }
        .background(Color(red: 0.87, green: 0.86, blue: 1.0).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Header
    private var header: some View {
        VStack(spacing: 10) {
            Image("Number Ninjas") // <-- your top icon name
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.top, 8)

            Text("Number Ninjas")
                .font(.system(size: 20, weight: .heavy))
                .foregroundColor(.black)

            Text("Count and write the number.")
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.black.opacity(0.75))

            Divider().opacity(0.35)
        }
        .padding(.top, 6)
    }

    // MARK: - One Question Card
    private func questionCard(_ q: Question) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 14) {

                // LEFT: images grid (adaptive = no cutting)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 54), spacing: 10)],
                          alignment: .leading,
                          spacing: 10) {
                    ForEach(0..<q.count, id: \.self) { _ in
                        Image(q.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 54, height: 54)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // RIGHT: Answer box + feedback
                VStack(spacing: 8) {
                    TextField("", text: binding(for: q))
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 26, weight: .bold))
                        .frame(width: 110, height: 60)
                        .background(Color.white.opacity(0.50))
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(borderColor(for: q), lineWidth: 3)
                        )

                    if let msg = feedbackText(for: q) {
                        HStack(spacing: 8) {
                            Image(systemName: isCorrect(q) ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(isCorrect(q) ? .green : .red)
                            Text(msg)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(isCorrect(q) ? .green : .red)
                        }
                        .transition(.opacity)
                    } else {
                        // keeps layout consistent even when empty
                        Color.clear.frame(height: 22)
                    }
                }
            }
        }
        .padding(14)
        .background(Color.white.opacity(0.22))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black.opacity(0.08), lineWidth: 1)
        )
    }

    // MARK: - Binding (stores answer per question)
    private func binding(for q: Question) -> Binding<String> {
        Binding(
            get: { answers[q.id, default: ""] },
            set: { newValue in
                // ✅ allow only digits
                let filtered = newValue.filter { $0.isNumber }
                answers[q.id] = filtered
            }
        )
    }

    // MARK: - Helpers
    private func isCorrect(_ q: Question) -> Bool {
        let text = answers[q.id, default: ""]
        return Int(text) == q.count
    }

    private func borderColor(for q: Question) -> Color {
        let text = answers[q.id, default: ""]
        if text.isEmpty { return .gray.opacity(0.45) }
        return isCorrect(q) ? .green : .red
    }

    private func feedbackText(for q: Question) -> String? {
        let text = answers[q.id, default: ""]
        if text.isEmpty { return nil }
        return isCorrect(q) ? "Correct" : "Try Again"
    }
}

// ✅ Preview (no circular reference)
struct NumberNinjasView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NumberNinjasView()
        }
    }
}
