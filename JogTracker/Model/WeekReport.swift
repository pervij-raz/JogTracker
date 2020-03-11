//
//  WeekReport.swift
//  JogTracker
//
//  Created by Ольга Бычок on 11/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

class WeekReport {
    
    var fromDate: Date?
    var toDate: Date?
    var averageSpeed: Int?
    var averageTime: Int?
    var totalDistance: Float?
    
    init(jogs: [Jog]?) {
        guard let jogs = jogs else {return}
        let sortedJogs = jogs.sorted {$0.dateInt ?? 0 < $1.dateInt ?? 0}
        self.fromDate = calendar.date(byAdding: .day, value: (sortedJogs.first?.weekday ?? 0) - 1, to: sortedJogs.first?.date ?? Date())
        self.toDate = calendar.date(byAdding: .day, value: 7 - (sortedJogs.last?.weekday ?? 0), to: sortedJogs.last?.date ?? Date())
        var distance: Float = 0
        var totalTime: Int = 0
        for jog in sortedJogs {
            distance += jog.distance ?? 0
            totalTime += jog.time ?? 0
        }
        self.totalDistance = distance
        self.averageTime = sortedJogs.count != 0 ? totalTime / sortedJogs.count : 0
        let a = round(totalTime != 0 ? distance / Float(totalTime) : 0)
        
        self.averageSpeed = a <= Float(Int.max) ? Int(a) : 0
    }
    
    
}
