//
//  ReviewsVC.swift
//  Castles In Europe
//
//  Created by Ozgur Hayat on 10/01/2021.
//

import UIKit

class ReviewsVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarUI()
    }
    
    private func configureNavBarUI() {
        navigationItem.title       = "Reviews"
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
