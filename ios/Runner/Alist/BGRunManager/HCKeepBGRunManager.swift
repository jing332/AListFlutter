import Foundation
import AVFoundation

@objc(HCKeepBGRunManager)
class HCKeepBGRunManager: NSObject {

    var playerBack: AVAudioPlayer?

    @objc static let shared = HCKeepBGRunManager()

    override private init() {
        super.init()
        setupAudioSession()
        // 静音文件
        if let filePath = Bundle.main.path(forResource: "jm", ofType: "mp3"),
           let fileURL = URL(string: filePath) {
            do {
                playerBack = try AVAudioPlayer(contentsOf: fileURL)
                playerBack?.prepareToPlay()
                playerBack?.volume = 0.01
                playerBack?.numberOfLoops = -1  // 无限循环播放
            } catch {
                print("AVAudioPlayer init failed: \(error)")
            }
        }
    }

    func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, options: .mixWithOthers) // 设置后台播放
            try audioSession.setActive(true)
        } catch {
            print("Error setting audio session category or activating it: \(error)")
        }
    }

    @objc func startBGRun() {
        playerBack?.play()
    }

    @objc func stopBGRun() {
        playerBack?.stop()
    }

    @objc static func moduleName() -> String! {
        return "HCKeepBGRunManager"
    }

    @objc static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
