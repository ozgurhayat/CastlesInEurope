//
//  CountryCell.swift
//  Castles In Europe
//
//  Created by Ozgur Hayat on 17/01/2021.
//

import UIKit

class CountryCell: UITableViewCell {
    
    var countryImageView = UIImageView()
    var countryTitleLabel  = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(countryImageView)
        addSubview(countryTitleLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: Image) {
        countryImageView.image = image.image
        countryTitleLabel.text = image.title
    }
    
    func configureImageView() {
        countryImageView.clipsToBounds      = true
        countryImageView.isOpaque           = true
        countryImageView.contentMode        = .scaleAspectFill
        countryImageView.layer.cornerRadius = 14
    }
    
    func configureTitleLabel() {
        countryTitleLabel.numberOfLines = 0
        countryTitleLabel.textAlignment = .center
    }
    
    func setImageConstraints() {
        countryImageView.translatesAutoresizingMaskIntoConstraints                 = false
//        countryImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        countryImageView.heightAnchor.constraint(equalToConstant: 300).isActive    = true
//        countryImageView.widthAnchor.constraint(equalTo: countryImageView.heightAnchor, multiplier: 16/9).isActive = true
        countryImageView.anchor(top: self.topAnchor, bottom: self.bottomAnchor)
        
    }
    
    func setTitleLabelConstraints() {
        countryTitleLabel.translatesAutoresizingMaskIntoConstraints                 = false
        countryTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        countryTitleLabel.heightAnchor.constraint(equalToConstant: 250).isActive     = true
        countryTitleLabel.anchor(top: countryImageView.topAnchor, paddingTop: 150)
    }
}

