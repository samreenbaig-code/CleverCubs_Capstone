import SwiftUI
import AVFoundation

struct ABCAdventureView: View {

    @State private var selectedLetter: String? = nil
    @State private var selectedImage: String? = nil
    @State private var showCorrect = false
    @State private var showWrong = false

    @State private var player: AVAudioPlayer?

    // Correct matches
    let correctMatches: [String: String] = [
        "A": "Apple",
        "B": "Ball",
        "C": "Cat",
        "D": "Dog",
        "E": "Elephant"
    ]

    // Order of letters & images as shown in your layout
    let letters = ["A", "B", "C", "D", "E"]
    let images = ["Cat", "Dog", "Elephant", "Ball", "Apple"]

    var body: some View {
        ZStack {

            // Background
            Color(red: 0.88, green: 0.88, blue: 1.0)
                .ignoresSafeArea()

            VStack(spacing: 4) {

                // HEADER IMAGE
                Image("ABC1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 110)

                Text("Tap the letter and the matching picture")
                    .font(.headline)
                    .padding(.bottom, 10)

                HStack {

                    // LEFT — LETTERS
                    VStack(spacing: 30) {
                        ForEach(letters, id: \.self) { letter in
                            Image(letter)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 50)
                                .padding(10)
                                .background(selectedLetter == letter ? Color.blue.opacity(0.2) : Color.clear)
                                .cornerRadius(12)
                                .onTapGesture {
                                    selectedLetter = letter
                                    selectedImage = nil
                                    showCorrect = false
                                    showWrong = false
                                }
                        }
                    }

                    Spacer()

                    // RIGHT — IMAGES
                    VStack(spacing: 30) {
                        ForEach(images, id: \.self) { img in
                            Image(img)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 50)
                                .padding(10)
                                .background(selectedImage == img ? Color.blue.opacity(0.2) : Color.white.opacity(0.20))
                                .cornerRadius(16)
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                                .onTapGesture {
                                    selectedImage = img
                                    checkMatch()
                                }
                        }
                    }
                }
                .padding(.horizontal, 30)

                Spacer()
            }

            // MARK: ✔ SUCCESS POPUP WITH CONFETTI
            if showCorrect {
                VStack {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 120))
                        .foregroundColor(.green)
                        .padding()

                    Text("Correct!")
                        .font(.largeTitle.bold())
                        .foregroundColor(.green)

                    ConfettiView()
                        .frame(width: 200, height: 200)
                }
                .transition(.scale)
            }

            // MARK: ❌ WRONG POPUP
            if showWrong {
                VStack {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 120))
                        .foregroundColor(.red)
                        .padding()

                    Text("Try again!")
                        .font(.largeTitle.bold())
                        .foregroundColor(.red)
                }
                .transition(.scale)
            }
        }
        .animation(.easeInOut, value: showCorrect)
        .animation(.easeInOut, value: showWrong)
    }

    // MARK: MATCH CHECKER
    func checkMatch() {
        guard let letter = selectedLetter,
              let img = selectedImage else { return }

        if correctMatches[letter] == img {
            showCorrect = true
            showWrong = false
            playSound(name: "Correct")
        } else {
            showWrong = true
            showCorrect = false
            playSound(name: "Wrong")
        }
    }

    // MARK: SOUND PLAYER
    func playSound(name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.play()
        }
    }
}


// MARK: CONFETTI VIEW
struct ConfettiView: View {
    var body: some View {
        TimelineView(.animation) { _ in
            Canvas { context, size in
                for _ in 0..<20 {
                    let x = CGFloat.random(in: 0...size.width)
                    let y = CGFloat.random(in: 0...size.height)
                    let rect = CGRect(x: x, y: y, width: 8, height: 12)
                    context.fill(Path(ellipseIn: rect),
                                 with: .color(Color.random))
                }
            }
        }
    }
}

extension Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
