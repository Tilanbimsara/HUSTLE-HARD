//
//  HomeViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 17/5/23.
//
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    var tableView: UITableView!
    var exercises: [Exercise] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createExercises()
    }

    func setupUI() {
        view.backgroundColor = .white

        // header view
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))

        // Add header image view
        let headerImageView = UIImageView(image: UIImage(named: "logo"))
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        headerView.addSubview(headerImageView)

        headerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0) // Fill the entire area
        }

       
        let titleLabel = UILabel()
        titleLabel.text = "Exercise List"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        titleLabel.textColor = .white
        headerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerImageView.snp.bottom).offset(8)
        }

        let headerLineView = UIView()
        headerLineView.backgroundColor = .black
        headerView.addSubview(headerLineView)

        headerLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.bottom.equalToSuperview()
        }

        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
        tableView.tableHeaderView = headerView // Set the header view
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func createExercises() {
        exercises = [
            Exercise(name: "Exercise 1", imageName: "logooo"),
            Exercise(name: "Exercise 2", imageName: "logooo"),
            Exercise(name: "Exercise 3", imageName: "logooo"),
            Exercise(name: "Exercise 4", imageName: "logooo"),
            Exercise(name: "Exercise 5", imageName: "logooo"),
            Exercise(name: "Exercise 6", imageName: "logooo")
        ]
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseTableViewCell
        let exercise = exercises[indexPath.row]
        cell.configure(with: exercise)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

class ExerciseTableViewCell: UITableViewCell {
    var exerciseImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        exerciseImageView = UIImageView()
        exerciseImageView.contentMode = .scaleAspectFit
        exerciseImageView.clipsToBounds = true
        contentView.addSubview(exerciseImageView)

        exerciseImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(1)
        }
    }

    func configure(with exercise: Exercise) {
        exerciseImageView.image = UIImage(named: exercise.imageName)
    }
}

struct Exercise {
    let name: String
    let imageName: String
}
