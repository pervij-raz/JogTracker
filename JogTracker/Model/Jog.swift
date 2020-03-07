//
//  Jog.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

struct Jog: Equatable {
    
    var id: String?
    var distance: Int?
    var time: Int?
    var date: String?
    
    var speed: Double {
        if let distance = self.distance, let time = self.time {
            return Double(distance/time).rounded(.up)
        }
        return 0
    }
    
    init(id: String?, distance: Int?, time: Int?, date: String?) {
        self.id = id
        self.distance = distance
        self.time = time
        self.date = date
    }
}
