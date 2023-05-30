//
//  ProfileViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 17/5/23.
//

import UIKit
import SnapKit
import SwiftKeychainWrapper

class ProfileViewController: UIViewController {
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let genderValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let birthdayValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let heightValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let weightValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    private let bmiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let bmiCalculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calculate BMI", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#0096FF")
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(calculateBMI), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        retrieveData()
    }
    
    private func setupUI() {
        let margin: CGFloat = 20
        
        view.addSubview(genderLabel)
        view.addSubview(genderValueLabel)
        view.addSubview(birthdayLabel)
        view.addSubview(birthdayValueLabel)
        view.addSubview(heightLabel)
        view.addSubview(heightValueLabel)
        view.addSubview(weightLabel)
        view.addSubview(weightValueLabel)
        view.addSubview(bmiLabel)
        view.addSubview(bmiCalculateButton)
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(margin)
            make.leading.equalToSuperview().offset(margin)
        }
        
        genderValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(genderLabel)
            make.trailing.equalToSuperview().inset(margin)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(margin)
            make.leading.equalToSuperview().offset(margin)
        }
        
        birthdayValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(birthdayLabel)
            make.trailing.equalToSuperview().inset(margin)
        }
        
        heightLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(margin)
            make.leading.equalToSuperview().offset(margin)
        }
        
        heightValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(heightLabel)
            make.trailing.equalToSuperview().inset(margin)
        }
        
        weightLabel.snp.makeConstraints { make in
            make.top.equalTo(heightLabel.snp.bottom).offset(margin)
            make.leading.equalToSuperview().offset(margin)
        }
        
        weightValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(weightLabel)
            make.trailing.equalToSuperview().inset(margin)
        }
        
        bmiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weightLabel.snp.bottom).offset(margin)
        }
        
        bmiCalculateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bmiLabel.snp.bottom).offset(margin)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    private func retrieveData() {
        let genderKey = "genderKey"
        let birthdayKey = "birthdayKey"
        let heightKey = "heightKey"
        let weightKey = "weightKey"
        
        if let gender = KeychainWrapper.standard.string(forKey: genderKey) {
            genderValueLabel.text = gender
        }
        
        if let birthday = KeychainWrapper.standard.string(forKey: birthdayKey) {
            birthdayValueLabel.text = birthday
        }
        
        if let height = KeychainWrapper.standard.string(forKey: heightKey) {
            heightValueLabel.text = height
        }
        
        if let weight = KeychainWrapper.standard.string(forKey: weightKey) {
            weightValueLabel.text = weight
        }
    }
    
    @objc private func calculateBMI() {
        let heightKey = "heightKey"
        let weightKey = "weightKey"
        
        guard let storedHeight = KeychainWrapper.standard.string(forKey: heightKey),
              let storedWeight = KeychainWrapper.standard.string(forKey: weightKey),
              let height = Double(storedHeight),
              let weight = Double(storedWeight)
        else {
            print("Failed to retrieve height and weight from Keychain")
            return
        }
        
        let bmi = weight / (height * height ) 
        bmiLabel.text = String(format: "BMI: %.1f", bmi)
    }
}
