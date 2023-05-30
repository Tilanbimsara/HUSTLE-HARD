//
//  ScheduleViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 17/5/23.
//

import UIKit
import SnapKit
import FirebaseFirestore

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var exerciseData: [[Exercise]] = []
    var firestore: Firestore!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
       // title = "Your Suggest Shedule"
        

        setupFirestore()
        fetchExerciseData()
        setupUI()
    }

    private func setupFirestore() {
        firestore = Firestore.firestore()
    }

    private func fetchExerciseData() {
        let exerciseCollectionNames = ["day-one", "day-two", "day-three", "day-four", "day-five", "day-six", "day-seven"]
        exerciseCollectionNames.forEach { collectionName in
            let exercisesCollection = firestore.collection(collectionName)
            exercisesCollection.getDocuments { [weak self] snapshot, error in
                guard let snapshot = snapshot else {
                    // Error handling
                    return
                }

                var exercises: [Exercise] = []

                for document in snapshot.documents {
                    let data = document.data()

                    if let exerciseName = data["name"] as? String,
                       let exerciseDescription = data["des"] as? String,
                       let exerciseImageName = data["pic"] as? String {
                        let exercise = Exercise(symbol: "", name: exerciseName, description: exerciseDescription, imageName: exerciseImageName)
                        exercises.append(exercise)
                    }
                }

                self?.exerciseData.append(exercises)

                // Update table view with exercise data
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }

    private func setupUI() {
        view.backgroundColor = .white

        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
        
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseData[section].count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return exerciseData.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dayNumber = section + 1
        return "Day \(dayNumber)"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        let exercise = exerciseData[indexPath.section][indexPath.row]

        if let image = UIImage(named: exercise.imageName) {
            let resizedImage = resizeToSize(image, CGSize(width: 60, height: 60))
            cell.imageView?.image = roundedImage(resizedImage)
        }

        cell.textLabel?.text = "\(exercise.symbol) \(exercise.name)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.text = exercise.description
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.textColor = UIColor(hex: "#757575")
        cell.backgroundColor = .clear
        cell.selectionStyle = .none

        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(hex: "#E0E0E0")
        cell.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }

        return cell
    }

    struct Exercise {
        let symbol: String
        let name: String
        let description: String
        let imageName: String
    }

    func resizeToSize(_ image: UIImage, _ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? image
    }

    func roundedImage(_ image: UIImage) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: image.size)
        let roundedImage = renderer.image { context in
            let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: image.size), cornerRadius: image.size.width / 4)
            path.addClip()
            image.draw(in: CGRect(origin: .zero, size: image.size))
        }
        return roundedImage.withRenderingMode(image.renderingMode)
    }
}
