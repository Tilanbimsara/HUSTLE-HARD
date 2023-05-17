//
//  HomeViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 17/5/23.
//
import UIKit
import SnapKit

class HomeViewController: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var titleLabel: UILabel!
    var imageViews: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createImageSlideshow()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        let headerView = UIView()
        headerView.backgroundColor = .systemYellow
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }
        
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
        headerView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(headerView.snp.width)
            make.height.equalTo(headerView.snp.height)
        }
        
        titleLabel = UILabel()
        titleLabel.text = "Trending"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(20)
        }
        
        let startButton = UIButton(type: .system)
        startButton.setTitle("Start Workout", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    func createImageSlideshow() {
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200) // Adjust the height as needed
        }
        
        let imageNames = ["logooo", "ex2", "logoo"] // Replace with your actual image names
        
        for imageName in imageNames {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
            
            imageView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.leading.equalTo(imageViews.last?.snp.trailing ?? scrollView.snp.leading)
                make.width.equalTo(scrollView.snp.width)
                make.height.equalTo(scrollView.snp.height)
            }
        }
        
        let contentWidth = CGFloat(imageViews.count) * view.bounds.width
        scrollView.contentSize = CGSize(width: contentWidth, height: 200)
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = imageNames.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom).offset(10)
        }
    }
    
    @objc func startButtonTapped() {
        // Handle start button action
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
    }
}
