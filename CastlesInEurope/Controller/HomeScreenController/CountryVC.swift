//
//  CastlesVC.swift
//  Castles In Europe
//
//  Created by Ozgur Hayat on 10/01/2021.
//

import UIKit

class CountryVC: UIViewController {
    
    var tableView = UITableView()
    var images: [Image] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = fetchData()
        configureNavBarUI()
        configureTableView()
        animateTable()
    }
    
    private func configureNavBarUI() {
//        navigationItem.title                                    = "Haunted Castles in Europe"
        //        navigationController?.navigationBar.barStyle  = .black
//        navigationController?.navigationBar.prefersLargeTitles  = false
        tabBarController?.navigationController?.isNavigationBarHidden = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 300
        tableView.insetsContentViewsToSafeArea = true
        tableView.fillSuperview()
        tableView.register(CountryCell.self, forCellReuseIdentifier: Cells.countryCell)
        
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.06, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}

extension CountryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.countryCell) as! CountryCell
        let image = images[indexPath.row]
        cell.set(image: image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.85) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}
