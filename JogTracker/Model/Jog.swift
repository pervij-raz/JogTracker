//
//  Jog.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

struct Jog: Equatable, Decodable {
    
    var id: Int?
    var distance: Double?
    var time: Int?
    var dateInt: Int?
    var userID: String?
    
    var speed: Int {
        if let distance = self.distance, let time = self.time {
            return Int(round(distance/Double(time)))
        }
        return 0
    }
    
    var date: Date? {
        let date = Date(timeIntervalSince1970: TimeInterval(dateInt ?? 0))
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: date))
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case distance
        case time
        case date
        case userID = "user_id"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(distance, forKey: .distance)
        try container.encode(time, forKey: .time)
        try container.encode(date, forKey: .date)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        distance = try container.decode(Double.self, forKey: .distance)
        time = try container.decode(Int.self, forKey: .time)
        dateInt = try container.decode(Int.self, forKey: .date)
        userID = try container.decode(String.self, forKey: .userID)
    }
    
    
}
