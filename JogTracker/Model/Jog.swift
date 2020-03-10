//
//  Jog.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

public var formatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    return formatter
}

@objc class Jog: NSObject, Decodable {
    
    var id: Int?
    var distance: Float?
    var time: Int?
    var dateInt: Int?
    var userID: String?
    
    var speed: Int {
        if let distance = self.distance, let time = self.time {
            return Int(round(distance/Float(time)))
        }
        return 0
    }
    
    var date: Date? {
        get {
            let date = Date(timeIntervalSince1970: TimeInterval(dateInt ?? 0))
            return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: date))
        }
    }
    
    var jogForRequestBody: [String: Any]? {
        if let distance = distance, let time = time, let date = date, let userID = userID {
            let dateString = formatter.string(from: date)
            var dict: [String: Any] = ["distance": distance, "time": time, "date": dateString, "user_id": userID]
            if self.id != nil {
                dict["jog_id"] = self.id
            }
            return dict
        } else {
            return nil
        }
    }
    
    var weekday: Int {
        return Calendar.current.dateComponents([.weekday], from: self.date ?? Date()).weekday ?? 0
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        distance = try container.decode(Float.self, forKey: .distance)
        time = try container.decode(Int.self, forKey: .time)
        dateInt = try container.decode(Int.self, forKey: .date)
        userID = try container.decode(String.self, forKey: .userID)
    }
    
    init(id: Int?, distance: Float, time: Int, date: String) {
        super.init()
        let date = formatter.date(from: date)
        self.dateInt = Int(date?.timeIntervalSince1970 ?? 0)
        self.time = time
        self.distance = distance
        self.userID = UserData.shared.id
        self.id = id
    }
    
    func equals (compareTo:Jog?) -> Bool {
        return
            self.id == compareTo?.id &&
                self.time == compareTo?.time &&
                self.distance == compareTo?.distance &&
                self.dateInt == compareTo?.dateInt &&
                self.userID == compareTo?.userID
    }
    
    
}
