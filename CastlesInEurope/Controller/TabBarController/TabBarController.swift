//
//  TabBarController.swift
//  Castles In Europe
//
//  Created by Ozgur Hayat on 10/01/2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationBar()
    }
    
    func customizeNavigationBar() {
        UITabBar.appearance().tintColor     = .systemIndigo
        UITabBar.appearance().barStyle      = .black
        navigationItem.hidesBackButton      = true
        viewControllers                     = [createCastlesNC(), createReviewsNC()]
        
    }
    
    func createCastlesNC() -> UINavigationController {
        let castlesVC        = CountryVC()
        castlesVC.title      = "Castles"
        castlesVC.tabBarItem = UITabBarItem(title: "Castles", image: UIImage(systemName: "house"), tag: 0)
        
        return UINavigationController(rootViewController: castlesVC)
    }
    
    func createReviewsNC() -> UINavigationController {
        let reviewsVC         = ReviewsVC()
        reviewsVC.title       = "Reviews"
        reviewsVC.tabBarItem  = UITabBarItem(title: "Reviews", image: UIImage(systemName: "pencil"), tag: 1)
        
        return UINavigationController(rootViewController: reviewsVC)
    }
}
