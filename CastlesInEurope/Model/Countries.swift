//
//  Countries.swift
//  Castles In Europe
//
//  Created by Ozgur Hayat on 14/01/2021.
//

import FirebaseFirestore

struct Category {
    var name: String
    var id: String
    var imgUrl: String
    var isActive: Bool = true
    var timeStamp: Timestamp
    
    init(
        name: String,
        id: String,
        imgUrl: String,
        isActive: Bool = true,
        timeStamp: Timestamp) {
        
        self.name = name
        self.id = id
        self.imgUrl = imgUrl
        self.isActive = isActive
        self.timeStamp = timeStamp
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imgUrl = data["imgUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
    //Turns our data to dictionary for firestore
    static func modelToData(category: Category) -> [String: Any] {
        let data : [String: Any] = [
            "name" : category.name,
            "id" : category.id,
            "imgUrl" : category.imgUrl,
            "isActive" : category.isActive,
            "timeStamp" : category.timeStamp
        ]
        return data
    }
    
    struct CityCategory {
        var title : String
        var imageName : String
    }
    
    var mainCategory = [
        CityCategory(title: "Istanbul: The Emperial Capital", imageName: "istanbul0"),
        CityCategory(title: "Alacati: Dance With the Wind", imageName: "alacati0"),
        CityCategory(title: "Bodrum: Loggerhead Turtles Nesting Ground", imageName: "bodrum0"),
        CityCategory(title: "Antalya: The Tourism Capital", imageName: "antalya"),
        CityCategory(title: "Cappadocia: Fairy Chimneys Beyond Dreams", imageName: "cappadocia0"),
        CityCategory(title: "Izmir: Pearl of the Aegean", imageName: "izmir0"),
        CityCategory(title: "Trabzon: An Inspiration for Travellers", imageName: "trabzon0"),
        CityCategory(title: "GobekliTepe: The first Temple of the World", imageName: "gobek0")
    ]
}
