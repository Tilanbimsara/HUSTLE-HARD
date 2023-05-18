//
//  SelectExerciseViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 18/5/23.
//

import UIKit
import SnapKit

class SelectExerciseViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let exerciseTypeStackView = UIStackView()
    private let continueButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        titleLabel.text = "Select Exercise Type"
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        exerciseTypeStackView.axis = .vertical
        exerciseTypeStackView.spacing = 20
        view.addSubview(exerciseTypeStackView)
        
        let exerciseTypes = [("", ""),("🏃", "Cardio"), ("💪", "Strength Training"), ("🧘‍♂️", "Yoga"), ("🧘‍♀️", "Pilates"), ("🙆‍♀️", "Stretching")]
        
        for exerciseType in exerciseTypes {
            let iconLabel = UILabel()
            iconLabel.text = exerciseType.0
            iconLabel.font = UIFont.systemFont(ofSize: 24)
            iconLabel.textColor = .black
            
            let exerciseTypeLabel = UILabel()
            exerciseTypeLabel.text = exerciseType.1
            exerciseTypeLabel.font = UIFont.systemFont(ofSize: 18)
            exerciseTypeLabel.textColor = .black
            
            let horizontalStackView = UIStackView(arrangedSubviews: [iconLabel, exerciseTypeLabel])
            horizontalStackView.spacing = 10
            horizontalStackView.alignment = .center
            
            exerciseTypeStackView.addArrangedSubview(horizontalStackView)
        }
        
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
        
        exerciseTypeStackView.snp.makeConstraints { make in
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
    
    @objc private func continueButtonTapped() {
        let mainTabBarController = MainTabBarViewController()
        navigationController?.pushViewController(mainTabBarController, animated: true)
    }
}
