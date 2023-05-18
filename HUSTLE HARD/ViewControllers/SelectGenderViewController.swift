//
//  SelectGenderViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 14/5/23.
//

import UIKit
import SnapKit

class SelectGenderViewController: UIViewController {
    
    private let selectGenderLabel = UILabel()
    private let stackView = UIStackView()
    private let continueButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSelectGenderLabel()
        setupGenderSelectionItems()
        setupContinueButton()
    }
    
    private func setupSelectGenderLabel() {
        selectGenderLabel.text = "Select Gender"
        selectGenderLabel.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        view.addSubview(selectGenderLabel)
        
        selectGenderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
    }
    
    private func setupGenderSelectionItems() {
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(selectGenderLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        let genderItems = [("🙎🏽‍♂️", "Male"), ("🙎🏽‍♀️", "Female")]
        
        for genderItem in genderItems {
            let emojiLabel = UILabel()
            emojiLabel.text = genderItem.0
            emojiLabel.textAlignment = .center
            emojiLabel.backgroundColor = UIColor(hex: "#0096FF")
            emojiLabel.layer.cornerRadius = 4
            emojiLabel.clipsToBounds = true
            
            let nameLabel = UILabel()
            nameLabel.text = genderItem.1
            nameLabel.textAlignment = .left
            
            let horizontalStackView = UIStackView(arrangedSubviews: [emojiLabel, nameLabel])
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = 10
            horizontalStackView.alignment = .center
            
            let itemView = UIView()
            itemView.addSubview(horizontalStackView)
            itemView.layer.cornerRadius = 4
            itemView.layer.borderWidth = 2
            itemView.layer.borderColor = UIColor.gray.cgColor
            
            stackView.addArrangedSubview(itemView)
            
            emojiLabel.snp.makeConstraints { make in
                make.width.height.equalTo(50)
            }
            
            horizontalStackView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            }
            
            itemView.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(80)
            }
        }
    }
    
    private func setupContinueButton() {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(hex: "#0096FF")
        continueButton.layer.cornerRadius = 25
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func continueButtonTapped() {
       
        let selectBirthdayViewController = SelectBirthdayViewController()
        navigationController?.pushViewController(selectBirthdayViewController, animated: true)
    }
}
