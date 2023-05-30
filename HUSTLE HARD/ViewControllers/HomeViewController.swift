//
//  HomeViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 17/5/23.
//
import UIKit
import SnapKit
import FirebaseFirestore

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var exerciseData: [Exercise] = []
    var firestore: Firestore!
    var exercisesCollection: CollectionReference!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFirestore()
        fetchExerciseData()
        setupUI()

        tableView.rowHeight = 100 // Adjust the value as needed
    }

    private func setupFirestore() {
        firestore = Firestore.firestore()
        exercisesCollection = firestore.collection("day-one")
    }


    
    private func fetchExerciseData() {
        exercisesCollection.getDocuments { [weak self] snapshot, error in
            guard let snapshot = snapshot else {
                // Error handling
                return
            }

            for document in snapshot.documents {
                let data = document.data()

                if let exerciseName = data["name"] as? String,
                   let exerciseDescription = data["des"] as? String,
                   let exerciseImageName = data["pic"] as? String,
                   let exerciseGIF = data["GIFUrl"] as? String,
                   let exerciseType = data["type"] as? String, exerciseType == UserManager.fitnessGoal {
                    let exercise = Exercise(symbol: "", name: exerciseName, description: exerciseDescription, imageName: exerciseImageName, GIFUrl: exerciseGIF)
                    self?.exerciseData.append(exercise)
                }
            }

            // Update table view with exercise data
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }


    private func setupUI() {
        view.backgroundColor = .white

        let headingContainerView = UIView()
        headingContainerView.backgroundColor = UIColor(hex: "#0096FF")
        view.addSubview(headingContainerView)
        headingContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }

        let headingLabel = UILabel()
        headingLabel.text = "YOUR TODAY'S SCHEDULE"
        headingLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        headingLabel.textColor = .white
        headingLabel.textAlignment = .center
        headingLabel.numberOfLines = 0
        headingContainerView.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 44, left: 16, bottom: 16, right: 16))
        }

        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
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

        // Load image from asset folder
        if let image = UIImage(named: exercise.imageName) {
            let resizedImage = image.resizeToSize(CGSize(width: 70, height: 70)) // Adjust the size as needed
            cell.imageView?.image = resizedImage.rounded() // Optional: You can round the image corners if desired
        }

        cell.textLabel?.text = "\(exercise.symbol) \(exercise.name)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        cell.textLabel?.textColor = .black
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedExercise = exerciseData[indexPath.row]
        let viewController = ExerciseViewController(exerciseName: selectedExercise.name, exerciseGIF: selectedExercise.GIFUrl)
            
        navigationController?.pushViewController(viewController, animated: true)
    }

    struct Exercise {
        let symbol: String
        let name: String
        let description: String
        let imageName: String
        let GIFUrl : String
    }
}

extension UIImage {
    func resizeToSize(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }

    func rounded() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let roundedImage = renderer.image { context in
            let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: size.width / 2)
            path.addClip()
            draw(in: CGRect(origin: .zero, size: size))
        }
        return roundedImage.withRenderingMode(renderingMode)
    }
}
