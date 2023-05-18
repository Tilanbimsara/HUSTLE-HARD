//
//  SelectBirthdayViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 14/5/23.
//
import UIKit
import SnapKit

class SelectBirthdayViewController: UIViewController {


let titleLabel = UILabel()
let datePicker = UIDatePicker()
let continueButton = UIButton()

override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
}

private func setupViews() {
    view.backgroundColor = .white
    
    titleLabel.text = "Select Birthday"
    titleLabel.font = UIFont.systemFont(ofSize: 26)
    titleLabel.textColor = .black
    view.addSubview(titleLabel)
    
    datePicker.datePickerMode = .date
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.maximumDate = Date()
    view.addSubview(datePicker)
    
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
        make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        make.centerX.equalToSuperview()
    }
    
    datePicker.snp.makeConstraints { make in
        make.top.equalTo(titleLabel.snp.bottom).offset(20)
        make.centerX.equalToSuperview()
        make.width.equalToSuperview().multipliedBy(0.8)
    }
    
    continueButton.snp.makeConstraints { make in
        make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        make.centerX.equalToSuperview()
        make.width.equalToSuperview().inset(20)
        make.height.equalTo(50)
    }
}

@objc private func continueButtonTapped() {
    
    let SelectHeightViewController = SelectHeightViewController()
    navigationController?.pushViewController(SelectHeightViewController, animated: true)
}

private func createContinueButton() -> UIButton {
    let button = UIButton()
    button.setTitle("Continue", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor(hex: "#0096FF")
    button.layer.cornerRadius = 25
    return button
}
}

