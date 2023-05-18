//
//  SplashViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 19/5/23.
//
import UIKit

class SplashViewController: UIViewController {
    
    private let appNameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupGradientBackground()
        setupAppNameLabel()
        animateSplash()
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupAppNameLabel() {
        appNameLabel.text = "HUSTLE HARD"
        appNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        appNameLabel.textColor = .white
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appNameLabel)
        
        NSLayoutConstraint.activate([
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func animateSplash() {
        appNameLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        appNameLabel.alpha = 1
        
        UIView.animate(withDuration: 2.5, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.appNameLabel.transform = .identity
            self.appNameLabel.alpha = 5
        }) { _ in
            self.transitionToLoginScreen()
        }
    }
    
    private func transitionToLoginScreen() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: false, completion: nil)
    }
}
