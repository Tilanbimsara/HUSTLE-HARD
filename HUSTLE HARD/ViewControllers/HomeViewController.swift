//
//  HomeViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 17/5/23.
//
import UIKit
import SnapKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let exerciseData = [
        Exercise(symbol: "   💪", name: "Push-ups"),
           Exercise(symbol: "   🏋️‍♀️", name: "Squats"),
           Exercise(symbol: "   🏃‍♂️", name: "Running"),
           Exercise(symbol: "   🏊‍♀️", name: "Swimming"),
           Exercise(symbol: "   🚴‍♂️", name: "Cycling"),
           Exercise(symbol: "   🧘‍♀️", name: "Yoga"),
           Exercise(symbol: "   🏋️‍♂️", name: "Weightlifting"),
           Exercise(symbol: "   ⛹️‍♀️", name: "Basketball"),
           Exercise(symbol: "   ⚽️", name: "Soccer"),
           Exercise(symbol: "   🏸", name: "Badminton"),
           Exercise(symbol: "   🚶‍♀️", name: "Walking"),
    ]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
   
    
    private func setupUI() {
        view.backgroundColor = .white
        
       
        let headingContainerView = UIView()
        headingContainerView.backgroundColor = .systemGray6
        view.addSubview(headingContainerView)
        headingContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        let headingLabel = UILabel()
        headingLabel.text = "YOUR TODAY SCHEDULE HERE"
        headingLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headingLabel.textColor = .black
     
        headingLabel.textAlignment = .center
        headingLabel.numberOfLines = 0
        headingContainerView.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
        
       
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headingContainerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        let exercise = exerciseData[indexPath.row]
        
        cell.textLabel?.text = "\(exercise.symbol) \(exercise.name)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 23)
     //   cell.imageView?.image = UIImage(named: "exercise_icon")
        return cell
    }
    
    // MARK: - Exercise Struct
    
    struct Exercise {
        let symbol: String
        let name: String
    }
}
