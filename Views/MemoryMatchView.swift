import SwiftUI

struct MemoryMatchView: View {

    struct Card: Identifiable {
        let id = UUID()
        let imageName: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
    }

    @State private var cards: [Card] = []
    @State private var firstIndex: Int? = nil
    @State private var lockBoard: Bool = false

    private let pairs = ["Cat", "shark", "Apple", "star_yellow", "sharpner", "Chick"]

    var body: some View {
        ZStack {
            Color(red: 0.87, green: 0.86, blue: 1.0).ignoresSafeArea()

            VStack(spacing: 10) {
                header

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 14), count: 4), spacing: 14) {
                    ForEach(cards.indices, id: \.self) { i in
                        cardView(i)
                    }
                }
                .padding(.horizontal, 16)

                Button("Restart") {
                    startGame()
                }
                .font(.system(size: 16, weight: .bold))
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.25))
                .cornerRadius(14)
                .padding(.top, 10)

                Spacer(minLength: 10)
            }
            .padding(.top, 10)
        }
        .onAppear { startGame() }
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(spacing: 8) {
            Image("Memory Match")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)

            Text("Memory Match")
                .font(.system(size: 20, weight: .bold))

            Text("Test your memory! Flip and match the pictures")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.black.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .padding(.bottom, 8)
    }

    private func cardView(_ index: Int) -> some View {
        let card = cards[index]

        return ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.16))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(card.isMatched ? Color.green.opacity(0.9) : Color.blue.opacity(0.8), lineWidth: 4)
                )
                .frame(height: 88)

            if card.isFaceUp || card.isMatched {
                Image(card.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 54, height: 54)
            } else {
                VStack(spacing: 4) {
                    Text("?")
                        .font(.system(size: 44, weight: .black))
                        .foregroundColor(Color.orange.opacity(0.8))
                    Image("tiny_ninja")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .opacity(0.6)
                }
            }
        }
        .scaleEffect(card.isMatched ? 1.05 : 1)
        .animation(.easeInOut(duration: 0.2), value: card.isMatched)
        .onTapGesture {
            flip(index)
        }
    }


    private func startGame() {
        var temp: [Card] = []
        let chosen = pairs.shuffled().prefix(6)  // 6 pairs = 12 cards (matches your grid)

        for name in chosen {
            temp.append(Card(imageName: name))
            temp.append(Card(imageName: name))
        }
        cards = temp.shuffled()
        firstIndex = nil
        lockBoard = false
    }

    private func flip(_ index: Int) {
        if lockBoard { return }
        if cards[index].isFaceUp || cards[index].isMatched { return }

        cards[index].isFaceUp = true

        if firstIndex == nil {
            firstIndex = index
            return
        }

        let first = firstIndex!
        if cards[first].imageName == cards[index].imageName {
            // match
            cards[first].isMatched = true
            cards[index].isMatched = true
            firstIndex = nil
        } else {
            // no match: flip back after delay
            lockBoard = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                cards[first].isFaceUp = false
                cards[index].isFaceUp = false
                firstIndex = nil
                lockBoard = false
            }
        }
    }
}

#Preview {
    NavigationStack { MemoryMatchView() }
}
