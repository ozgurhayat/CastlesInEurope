//
//  Constants.swift
//  Castles in Europe
//
//  Created by Ozgur Hayat on 01/12/2020.
//

import Foundation
import Firebase

let MSG_METRICS = "Discover"
let MSG_DASHBOARD = "Weather & Map"
let MSG_NOTIFICATIONS = "Share Your Story"
let MSG_ONBOARDING_METRICS = "Discover all legend haunted castles all around Europe"
let MSG_ONBOARDING_NOTIFICATIONS = "Share your reviews and stories"
let MSG_ONBOARDING_DASHBOARD = "Check out weather and map before travel"
let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let MSG_RESET_PASSWORD_LINK_SENT = "We sent a link to your email to reset your password"


struct Images {
    static let noStoryboard = UIImage(named: "Nostoryboard")!
    static let softSkills   = UIImage(named: "mayuko-2")!
}
