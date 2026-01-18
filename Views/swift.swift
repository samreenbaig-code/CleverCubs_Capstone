import Foundation
import AVFoundation

class MusicManager {
    static let shared = MusicManager()
    private var player: AVAudioPlayer?

    private init() {}

    func playMusic(named name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("❌ bg_music.mp3 not found.")
            return
        }

        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 // 🔁 Loop forever
            player?.play()
        } catch {
            print("❌ Error playing music: \(error.localizedDescription)")
        }
    }

    func stopMusic() {
        player?.stop()
    }

    func pauseMusic() {
        player?.pause()
    }

    func resumeMusic() {
        player?.play()
    }

    func isPlaying() -> Bool {
        return player?.isPlaying ?? false
    }
}
