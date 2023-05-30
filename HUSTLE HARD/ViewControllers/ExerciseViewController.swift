//
//  ExerciseViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 20/5/23.
//

import UIKit
import WebKit
import AVFoundation
import AVKit

class ExerciseViewController: UIViewController, WKNavigationDelegate {
    
    
    private var webView: WKWebView!
    private var nameLabel: UILabel!
    private var startStopButton: UIButton!
    private var videoButton: UIButton!
    private var timeCounterLabel: UILabel!
    
    private var exerciseURL: URL?
    private var isExerciseRunning = false
    private var exerciseTimer: Timer?
    private var exerciseDuration = 0
    
    var avPlayerViewController = AVPlayerViewController()
       var avPlayer:AVPlayer?
    
    var ExName = ""
    var ExGIF = ""
    
    //MARK: - Initialization
    init(exerciseName: String, exerciseGIF: String) {
            super.init(nibName: nil, bundle: nil)
        self.ExName = exerciseName
        self.ExGIF = exerciseGIF
        
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        // Initialize the WKWebView
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        // Add constraints for the WKWebView
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // Initialize the time counter label
        nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 28)
        nameLabel.text = ExName
        view.addSubview(nameLabel)
        
        // Add constraints for the time counter label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 5).isActive = true
        
        // Initialize the start/stop button
        startStopButton = UIButton(type: .system)
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        view.addSubview(startStopButton)
        
        // Add constraints for the start/stop button
        startStopButton.translatesAutoresizingMaskIntoConstraints = false
        startStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startStopButton.topAnchor.constraint(equalTo:  nameLabel.bottomAnchor, constant: 16).isActive = true
        
        // Initialize the time counter label
        timeCounterLabel = UILabel()
        timeCounterLabel.textAlignment = .center
        timeCounterLabel.font = UIFont.systemFont(ofSize: 24)
        timeCounterLabel.text = "00:00"
        view.addSubview(timeCounterLabel)
        
        // Add constraints for the time counter label
        timeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        timeCounterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeCounterLabel.topAnchor.constraint(equalTo: startStopButton.bottomAnchor, constant: 16).isActive = true
        
        // Initialize the video button
        videoButton = UIButton(type: .system)
        videoButton.setTitle("PLAY VIDEO", for: .normal)
        videoButton.addTarget(self, action: #selector(videoButtonTapped), for: .touchUpInside)
        view.addSubview(videoButton)
        
        // Add constraints for the video button
        videoButton.translatesAutoresizingMaskIntoConstraints = false
        videoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        videoButton.topAnchor.constraint(equalTo: timeCounterLabel.bottomAnchor, constant: 20).isActive = true
        
        configVideoPlayer()
    }
    
    private func configVideoPlayer(){
        let urlPathString:String? = Bundle.main.path(forResource: "WhatsApp Video 2023-05-30 at 10.11.03 PM (1)", ofType: "mp4")
        if let urlPath = urlPathString {
            let videoUrl = NSURL(fileURLWithPath: urlPath)
            
            self.avPlayer = AVPlayer(url: videoUrl as URL)
            self.avPlayerViewController.player = self.avPlayer
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Load the exercise GIF from a URL
        let exerciseURLString = ExGIF
        if let url = URL(string: exerciseURLString) {
            exerciseURL = url
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @objc private func startStopButtonTapped() {
        if isExerciseRunning {
            stopExercise()
        } else {
            startExercise()
        }
    }
    
    private func startExercise() {
        isExerciseRunning = true
        startStopButton.setTitle("Stop", for: .normal)
        
        // Start the exercise timer
        exerciseDuration = 0
        exerciseTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeCounter), userInfo: nil, repeats: true)
    }
    
    private func stopExercise() {
        isExerciseRunning = false
        startStopButton.setTitle("Start", for: .normal)
        
        // Stop the exercise timer
        exerciseTimer?.invalidate()
        exerciseTimer = nil
    }
    
    @objc private func updateTimeCounter() {
        exerciseDuration += 1
        let minutes = exerciseDuration / 60
        let seconds = exerciseDuration % 60
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        timeCounterLabel.text = timeString
    }
    
    @objc private func videoButtonTapped(){
        
        self.present(self.avPlayerViewController, animated: true) {
            self.avPlayerViewController.player?.play()
        }
    }
}

