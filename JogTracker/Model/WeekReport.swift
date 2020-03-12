//
//  WeekReport.swift
//  JogTracker
//
//  Created by Ольга Бычок on 11/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

class WeekReport {
    
    var from: Int?
    var to: Int?
    var averageSpeed: Int?
    var averageTime: Int?
    var totalDistance: Float?
    
    var fromDate: Date? {
        let date = Date(timeIntervalSince1970: TimeInterval(from ?? 0))
        let day = Calendar.current.dateComponents([.weekday], from: date).weekday ?? 0
        return Calendar.current.date(byAdding: .day, value: 1 - day, to: date)
    }
    
    var toDate: Date? {
        let date = Date(timeIntervalSince1970: TimeInterval(to ?? 0))
        let day = Calendar.current.dateComponents([.weekday], from: date).weekday ?? 0
        return Calendar.current.date(byAdding: .day, value: 1 - day, to: date)
    }
    
    init(jogs: [Jog]?) {
        guard let jogs = jogs else {return}
        let sortedJogs = jogs.sorted {$0.dateInt ?? 0 < $1.dateInt ?? 0}
        self.from = sortedJogs.first?.dateInt
        self.to = sortedJogs.last?.dateInt
        var distance: Float = 0
        var totalTime: Int = 0
        for jog in sortedJogs {
            distance += jog.distance ?? 0
            totalTime += jog.time ?? 0
        }
        self.totalDistance = distance
        self.averageTime = sortedJogs.count != 0 ? totalTime / sortedJogs.count : 0
        let a = round(totalTime != 0 ? distance / Float(totalTime) : 0)
        
        self.averageSpeed = a <= Float(Int.max) ? Int(a) : Int.max
    }
    
    
}
