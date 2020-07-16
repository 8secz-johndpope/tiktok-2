import UIKit
import AVFoundation

class VideoContainerView: UIView {

    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        guard let url = Bundle.main.url(forResource: "Anal-2", withExtension: "mp4") else { return }
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = CGRect(origin: .zero,
                                    size: CGSize(width: UIScreen.main.bounds.width,
                                                 height: UIScreen.main.bounds.height - (UIDevice.current.isPad ? 363 : 275)))
        playerLayer?.videoGravity = .resizeAspectFill
        if let playerLayer = playerLayer {
            layer.addSublayer(playerLayer)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoEndReached), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        player?.play()
    }
    
    @objc private func videoEndReached() {
        player?.pause()
        player?.seek(to: .zero)
        player?.play()
    }

}
