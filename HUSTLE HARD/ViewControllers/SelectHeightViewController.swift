import UIKit
import SnapKit
import SwiftKeychainWrapper

class SelectHeightViewController: UIViewController, UITextFieldDelegate {
    
    private let titleLabel = UILabel()
    private let unitSegmentedControl = UISegmentedControl(items: ["m"])
    private let heightTextField = UITextField()
    private let continueButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "Add Height"
        titleLabel.font = UIFont.systemFont(ofSize: 26)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        unitSegmentedControl.selectedSegmentIndex = 0
        view.addSubview(unitSegmentedControl)
        
        heightTextField.placeholder = "Enter Height"
        heightTextField.delegate = self
        view.addSubview(heightTextField)
        
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
        
        heightTextField.snp.makeConstraints { make in
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
        // Perform validation
        guard let heightText = heightTextField.text, !heightText.isEmpty else {
            showAlert(message: "Please enter your height")
            return
        }
        
        let decimalRegex = "^[0-9]+(\\.[0-9]+)?$"
        let decimalPredicate = NSPredicate(format: "SELF MATCHES %@", decimalRegex)
        
        if !decimalPredicate.evaluate(with: heightText) {
            showAlert(message: "Please enter a valid height")
            return
        }
        
        // Store height data in Keychain
        let heightKey = "heightKey"
        let isSet = KeychainWrapper.standard.set(heightText, forKey: heightKey)
        if isSet {
            let selectWeightViewController = SelectWeightViewController()
            navigationController?.pushViewController(selectWeightViewController, animated: true)
        } else {
            showAlert(message: "Failed to store height data")
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
