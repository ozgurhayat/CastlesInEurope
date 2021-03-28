//
//  DummyData.swift
//  Castles In Europe
//
//  Created by Ozgur Hayat on 17/01/2021.
//

import UIKit

struct Image {
    var image: UIImage
    var title: String
}

extension CountryVC {
    
    func fetchData() -> [Image] {
        let image1 = Image(image: Images.noStoryboard, title: "No-storyboard")
        let image2 = Image(image: Images.softSkills, title: "5 softSkill")
        
        return [image1, image2]
    }
}
