//
//  ExerciseViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 19/5/23.
//
import UIKit

class StartViewController: UIViewController {
    
  
    let topImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let firstLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont(name: "Poppins-Bold", size: 28)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Hustle Hard Fitness"
        return label
    }()
    
    let secLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Light", size: 22)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Be Strong"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 0)
        label.sizeToFit()
        return label
    }()
    
    let button : UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Building Your Body", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#FFFFFF")
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let hStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    let vStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()
    
    let mainHolderView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#0096FF")
        
        addComponents()
        setupConstraints()
        
        button.addTarget(self, action: #selector(goNext), for: .touchUpInside)
    }
    
    @objc func goNext() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    func addComponents() {
        view.addSubview(topImage)
        view.addSubview(firstLabel)
        view.addSubview(secLabel)
        view.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            topImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topImage.topAnchor.constraint(equalTo: view.topAnchor),
            topImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250)
        ])
        
        NSLayoutConstraint.activate([
            firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstLabel.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            secLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: secLabel.bottomAnchor, constant: 10),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        

    }
}
