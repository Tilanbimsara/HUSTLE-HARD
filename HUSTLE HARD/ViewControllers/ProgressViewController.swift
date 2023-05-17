//
//  ProgressViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 17/5/23.
//

import UIKit
import AVFoundation

class ProgressViewController: UIViewController {
    
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var isPlaying = false
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let pauseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pause", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        return button
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
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        pauseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
        }
    }
    
    private func setupPlayer() {
        guard let url = URL(string: "https://m.soundcloud.com/urlmusic/pegboard-nerds-give-a-little-love") else {
            print("Invalid music URL")
            return
        }
        
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
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
}
