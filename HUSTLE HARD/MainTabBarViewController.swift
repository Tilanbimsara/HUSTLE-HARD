//
//  ViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 14/5/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBlue
        
        let vc1 = UINavigationController(rootViewController:HomeViewController())
        let vc2 = UINavigationController(rootViewController:MydetailsViewController())
        let vc3 = UINavigationController(rootViewController:SeachViewController())
        let vc4 = UINavigationController(rootViewController:DoneExrciseViewController())
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "house")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.circle.fill")
        
        
        vc1.title = "Home"
        vc2.title = "My Details"
        vc3.title = "Seach"
        vc4.title = "Done Exrcise"
        
        tabBar.tintColor = .label
        
        
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }


}

