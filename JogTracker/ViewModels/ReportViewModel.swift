//
//  ReportViewModel.swift
//  JogTracker
//
//  Created by Ольга Бычок on 10/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

let calendar = Calendar(identifier: .iso8601)

class ReportViewModel {
    
    var jogs: [Jog]? {
        return UserData.shared.jogs
    }
    
    var reports: [WeekReport] = []
    
    func filterJogs() {
        var weeks: [[Jog]] = []
        guard let jogs = self.jogs else {return}
        for jog in jogs {
            let week = jogs.filter {return calendar.isDate($0.date ?? Date(), equalTo: jog.date ?? Date(), toGranularity: .weekOfYear)}
            weeks.append(week)
        }
        let filteredWeeks = Set(weeks)
        for week in filteredWeeks {
            let report = WeekReport(jogs: week)
            reports.append(report)
        }
    }
    
    
    
}



