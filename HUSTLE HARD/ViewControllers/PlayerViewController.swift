//
//  ProgressViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 17/5/23.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var isPlaying = false

    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()

    private let pauseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pause", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        return button
    }()

    private let trackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupPlayer()
    }

    private func setupUI() {
        view.addSubview(playButton)
        view.addSubview(pauseButton)
        view.addSubview(trackLabel)
        view.addSubview(timeLabel)

        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(300)
            make.width.equalTo(120)
            make.height.equalTo(80)
        }

        pauseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(playButton.snp.bottom).offset(20)
            make.width.equalTo(120)
            make.height.equalTo(80)
        }

        trackLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pauseButton.snp.bottom).offset(20)
        }

        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(trackLabel.snp.bottom).offset(8)
        }
    }

    private func setupPlayer() {
        guard let url = URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3") else {
            print("Invalid music URL")
            return
        }
    
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)

        // Update track name
        let trackName = "Step Fast"
        trackLabel.text = trackName

        // Update playing time
        let duration = playerItem?.asset.duration.seconds ?? 0
        let formattedDuration = formatTime(duration)
        timeLabel.text = "Duration: \(formattedDuration)"
    }

    @objc private func playButtonTapped() {
        if !isPlaying {
            player?.play()
            isPlaying = true
        }
    }

    @objc private func pauseButtonTapped() {
        if isPlaying {
            player?.pause()
            isPlaying = false
        }
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
