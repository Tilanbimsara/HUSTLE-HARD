//
//  ScheduleViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 17/5/23.
//

import UIKit
import SnapKit

class ScheduleViewController: UIViewController {


private let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorStyle = .none
    tableView.register(ExerciseScheduleTableViewCell.self, forCellReuseIdentifier: ExerciseScheduleTableViewCell.identifier)
    return tableView
}()

private var exerciseSchedules: [String: [String]] = [
    "Monday": ["Squats", "Front press","Back Press"],
    "Tuesday": ["Squats", "Running", "Walking"],
    "Wednesday": ["swimming", "Walking"],
    "Thursday": ["Back Press"],
    "Friday": ["Squats", "Front press"],
    "Saturday": ["Squats", "Running", "Front press"],
    "Sunday": ["Rest Day"]
]

override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupTableView()
}

private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints { make in
        make.edges.equalToSuperview()
    }
}
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return daysOfWeek.count
}


func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseScheduleTableViewCell.identifier, for: indexPath) as! ExerciseScheduleTableViewCell
    let dayOfWeek = daysOfWeek[indexPath.row]
    let exercises = exerciseSchedules[dayOfWeek] ?? []
    cell.configure(dayOfWeek: dayOfWeek, exercises: exercises)
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
}
}

class ExerciseScheduleTableViewCell: UITableViewCell {
static let identifier = "ExerciseScheduleTableViewCell"


private let dayLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
}()

private let exercisesLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 16)
    return label
}()

override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(dayLabel)
    contentView.addSubview(exercisesLabel)
    
    dayLabel.snp.makeConstraints { make in
        make.leading.equalToSuperview().offset(16)
        make.top.equalToSuperview().offset(8)
    }
    
    exercisesLabel.snp.makeConstraints { make in
        make.leading.equalTo(dayLabel)
        make.trailing.equalToSuperview().offset(-16)
        make.top.equalTo(dayLabel.snp.bottom).offset(8)
        make.bottom.equalToSuperview().offset(-8)
    }
    
    contentView.layer.cornerRadius = 8
    contentView.backgroundColor = .white
    contentView.layer.shadowColor = UIColor.black.cgColor
    contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
    contentView.layer.shadowRadius = 4
    contentView.layer.shadowOpacity = 0.2
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}

func configure(dayOfWeek: String, exercises: [String]) {
    dayLabel.text = dayOfWeek
    exercisesLabel.text = exercises.joined(separator: "\n")
}
}
