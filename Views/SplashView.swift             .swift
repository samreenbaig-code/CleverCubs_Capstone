import SwiftUI

struct SplashView: View {
    @State private var goNext = false
    @State private var isMusicOn = true

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                // 🔇 Music Toggle Button (top-right)
                HStack {
                    Spacer()
                    Button(action: {
                        if isMusicOn {
                            MusicManager.shared.pauseMusic()
                        } else {
                            MusicManager.shared.resumeMusic()
                        }
                        isMusicOn.toggle()
                    }) {
                        Image(systemName: isMusicOn ? "speaker.wave.2.fill" : "speaker.slash.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.white.opacity(0.3))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)

                // 🧠 App Logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 500)
                    .accessibilityLabel("logo")
                    .overlay(
                        Group {
                            if UIImage(named: "logo") == nil {
                                Text("Clever Clubs")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(AppTheme.primary)
                            }
                        }
                    )

                Spacer()

                // 🚀 Navigation to Welcome Page
                NavigationLink(destination: WelcomeView(), isActive: $goNext) { EmptyView() }

                PrimaryButton(title: "Continue", systemImage: "arrow.right") {
                    goNext = true
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            MusicManager.shared.playMusic(named: "bg_music")
        }
        // Optional: keep music playing after this
        // .onDisappear {
        //     MusicManager.shared.stopMusic()
        // }
    }
}
