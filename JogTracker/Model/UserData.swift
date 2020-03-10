//
//  UserData.swift
//  JogTracker
//
//  Created by Ольга Бычок on 08/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

class UserData {
    
    static let shared = UserData()
    
    private init() {
    }
    
    open var id: String? {
        get {
            return UserDefaults.standard.string(forKey: "userID")
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "userID")
        }
    }
    open var jogs: [Jog]?
}
