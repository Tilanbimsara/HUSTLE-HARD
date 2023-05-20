//
//  SelectExerciseViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 18/5/23.
//

import UIKit
import SnapKit

class SelectExerciseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let titleLabel = UILabel()
    private let exerciseTypePickerView = UIPickerView()
    private let continueButton = UIButton()
    
    private let exerciseTypes = [
        "Cardio",
        "Strength Training",
        "Fat Burn",
        "Yoga",
        "Bulk Body",
        "Weight Loss"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
        exerciseTypePickerView.dataSource = self
        exerciseTypePickerView.delegate = self
    }
    
    private func setupViews() {
        titleLabel.text = "Select Exercise Type"
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        view.addSubview(exerciseTypePickerView)
        
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
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        exerciseTypePickerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(40)
        }
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.width.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exerciseTypes.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exerciseTypes[row]
    }
    
    // MARK: - Actions
    
    @objc private func continueButtonTapped() {
        let mainTabBarController = MainTabBarViewController()
        navigationController?.pushViewController(mainTabBarController, animated: true)
    }
}
