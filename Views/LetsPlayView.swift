import SwiftUI

struct LetsPlayView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.87, green: 0.86, blue: 1.0)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 28) {
                        Text("Let’s Play")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(.purple)
                            .padding(.top, 16)

                        VStack(spacing: 26) {
                            HStack(spacing: 22) {
                                NavigationLink(destination: ABCAdventureView()) {
                                    gameCard(imageName: "ABC1",
                                             title: "ABC Adventure",
                                             color: Color.pink.opacity(0.25))
                                }
                                .buttonStyle(.plain)

                                NavigationLink(destination: NumberNinjasView()) {
                                    gameCard(imageName: "Number Ninjas",
                                             title: "Number Ninjas",
                                             color: Color.green.opacity(0.25))
                                }
                                .buttonStyle(.plain)
                            }

                            HStack(spacing: 22) {
                                NavigationLink(destination: ShapeSafariView()) {
                                    gameCard(imageName: "Shape Safari",
                                             title: "Shape Safari",
                                             color: Color.orange.opacity(0.25))
                                }
                                .buttonStyle(.plain)

                                NavigationLink(destination: ColorQuestView()) {
                                    gameCard(imageName: "Color Quest",
                                             title: "Color Quest",
                                             color: Color.blue.opacity(0.25))
                                }
                                .buttonStyle(.plain)
                            }

                            HStack(spacing: 22) {
                                NavigationLink(destination: MemoryMatchView()) {
                                    gameCard(imageName: "Memory Match",
                                             title: "Memory Match",
                                             color: Color.purple.opacity(0.25))
                                }
                                .buttonStyle(.plain)

                                NavigationLink(destination: LetterTraceView()) {
                                    gameCard(imageName: "LetterTrace",
                                             title: "LetterTrace",
                                             color: Color.yellow.opacity(0.25))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.bottom, 30)
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func gameCard(imageName: String, title: String, color: Color) -> some View {
        VStack(spacing: 12) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
                .padding(14)
                .background(color)
                .cornerRadius(26)
                .shadow(radius: 6)

            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    LetsPlayView()
}
