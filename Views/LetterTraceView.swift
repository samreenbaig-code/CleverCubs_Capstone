import SwiftUI
import AVFoundation

struct LetterTraceView: View {

    // MARK: - Tracing State
    @State private var currentDrawing: [CGPoint] = []
    @State private var savedDrawings: [[CGPoint]] = []

    // MARK: - Letter Progress
    @State private var currentIndex: Int = 0
    @State private var showCompleteMessage = false

    // MARK: - Trace Sound Only
    @State private var tracePlayer: AVAudioPlayer?

    // Letters to trace
    let letters = ["A", "B", "C", "D", "E", "F"]

    var body: some View {
        ZStack {
            // 🌈 Background
            Image("bg1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {

                Text("Trace the Letter")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 10)

                // ✏️ Big Letter + Tracing Area
                ZStack {
                    GeometryReader { geo in
                        Text(currentLetter)
                            .font(.system(size: geo.size.width * 0.7, weight: .black))
                            .foregroundColor(.gray.opacity(0.25))
                            .frame(width: geo.size.width, height: geo.size.height)

                        DrawingPath(paths: savedDrawings + [currentDrawing])
                            .stroke(Color.pink, lineWidth: 7)
                    }
                }
                .frame(height: 320)
                .background(Color.white.opacity(0.15))
                .cornerRadius(22)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if currentDrawing.isEmpty {
                                playTraceSound()
                            }
                            currentDrawing.append(value.location)
                        }
                        .onEnded { _ in
                            // Save only real traces (not taps)
                            if currentDrawing.count > 12 {
                                savedDrawings.append(currentDrawing)
                            }
                            currentDrawing = []

                            // ✅ Complete only after enough tracing
                            if savedDrawings.count >= 2 {
                                completeLetter()
                            }
                        }
                )

                // 🎉 Completion Message
                if showCompleteMessage {
                    Text("✅ Great Job!")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.green)
                        .transition(.scale)
                }

                Text("Letter \(currentIndex + 1) of \(letters.count)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black.opacity(0.6))

                // 🧼 Clear Button
                Button("Clear") {
                    resetTracing()
                }
                .font(.system(size: 16, weight: .bold))
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.4))
                .cornerRadius(14)

                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // 🚫 Stop global background music on this page
            MusicManager.shared.stopMusic()
        }
    }

    // MARK: - Helpers

    var currentLetter: String {
        letters[currentIndex]
    }

    private func completeLetter() {
        showCompleteMessage = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            moveToNextLetter()
        }
    }

    private func moveToNextLetter() {
        showCompleteMessage = false
        resetTracing()

        if currentIndex < letters.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0 // restart or later show "All Done!"
        }
    }

    private func resetTracing() {
        savedDrawings = []
        currentDrawing = []
    }

    // MARK: - Trace Sound

    private func playTraceSound() {
        guard let path = Bundle.main.path(forResource: "trace_start", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)
        tracePlayer = try? AVAudioPlayer(contentsOf: url)
        tracePlayer?.play()
    }
}

// MARK: - Drawing Shape
struct DrawingPath: Shape {
    let paths: [[CGPoint]]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for stroke in paths {
            guard let first = stroke.first else { continue }
            path.move(to: first)
            for point in stroke.dropFirst() {
                path.addLine(to: point)
            }
        }
        return path
    }
}

#Preview {
    NavigationStack {
        LetterTraceView()
    }
}
