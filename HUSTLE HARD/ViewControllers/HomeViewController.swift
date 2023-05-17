//
//  HomeViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 17/5/23.
//
import UIKit
import SnapKit

class HomeViewController: UIViewController {

    let buttonImages = ["bt1", "bt2", "bt3", "bt4", "bt5"] // Replace with your actual button image names
    var buttonImageViews: [UIImageView] = []
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createButtonImageViews()
        configureScrollView()
        configurePageControl()
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

        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200) // Adjust the height as needed
        }
    }

    func createButtonImageViews() {
        for imageName in buttonImages {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            buttonImageViews.append(imageView)
        }
    }

    func configureScrollView() {
        let buttonSize = CGSize(width: 120, height: 120) // Adjust the button size as needed
        let buttonSpacing: CGFloat = 20 // Adjust the spacing between buttons as needed

        for (index, imageView) in buttonImageViews.enumerated() {
            let buttonView = UIView()
            buttonView.addSubview(imageView)

            imageView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(buttonSize)
            }

            scrollView.addSubview(buttonView)

            buttonView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(buttonSize.width)
                make.leading.equalToSuperview().offset(CGFloat(index) * (buttonSize.width + buttonSpacing))
            }
        }

        let contentWidth = CGFloat(buttonImageViews.count) * (buttonSize.width + buttonSpacing) - buttonSpacing
        scrollView.contentSize = CGSize(width: contentWidth, height: 200)
    }

    func configurePageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = buttonImageViews.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        view.addSubview(pageControl)

        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom).offset(10)
        }
    }
}
