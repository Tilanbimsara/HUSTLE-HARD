//
//  HomeViewController.swift
//  HUSTLE HARD
//
//  Created by Tilan on 17/5/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: ProgressViewController())
        let vc3 = UINavigationController(rootViewController: ScheduleViewController())
        let vc4 = UINavigationController(rootViewController: ProfileViewController())
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
       
        vc2.tabBarItem.image = UIImage(systemName: "calendar.badge.clock.rtl")
        vc3.tabBarItem.image = UIImage(systemName: "dumbbell.fill")
        vc4.tabBarItem.image = UIImage(systemName: "person.crop.square.fill")
        
        vc1.title = "Today"
        vc2.title = "progress"
        vc3.title = "Schedule"
        vc4.title = "profile"
        
        
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
    

    

}
