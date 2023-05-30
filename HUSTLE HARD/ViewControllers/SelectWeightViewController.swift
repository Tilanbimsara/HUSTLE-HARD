//
//  SelectWeightViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 14/5/23.
//

import UIKit
import SnapKit
import SwiftKeychainWrapper

class SelectWeightViewController: UIViewController, UITextFieldDelegate {
    
    private let titleLabel = UILabel()
    private let unitSegmentedControl = UISegmentedControl(items: ["KG"])
    private let weightTextField = UITextField()
    private let continueButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "Add Weight"
        titleLabel.font = UIFont.systemFont(ofSize: 26)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        unitSegmentedControl.selectedSegmentIndex = 0
        view.addSubview(unitSegmentedControl)
        
        weightTextField.placeholder = "Enter Weight"
        weightTextField.delegate = self
        view.addSubview(weightTextField)
        
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(hex: "#0096FF")
        continueButton.layer.cornerRadius = 25
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        view.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
        }
        
        unitSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(unitSegmentedControl.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func continueButtonTapped() {
        //  validation
        guard let weightText = weightTextField.text, !weightText.isEmpty else {
            showAlert(message: "Please enter your weight")
            return
        }
        
        let numericRegex = "^[0-9]+$"
        let numericPredicate = NSPredicate(format: "SELF MATCHES %@", numericRegex)
        
        if !numericPredicate.evaluate(with: weightText) {
            showAlert(message: "Please enter a valid weight")
            return
        }
        
        let weightKey = "weightKey"
        let isSet = KeychainWrapper.standard.set(weightText, forKey: weightKey)
        if isSet {
            let selectExerciseViewController = SelectExerciseViewController()
            navigationController?.pushViewController(selectExerciseViewController, animated: true)
        } else {
            showAlert(message: "Failed to store weight data")
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
