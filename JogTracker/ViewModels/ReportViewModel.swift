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
    
    func filterJogs(handler: @escaping Handler) {
        DispatchQueue.main.async { [weak self] in
            var weeks: [[Jog]] = []
            do {
                guard var jogs = self?.jogs else {return}
                jogs = jogs.sorted{$0.dateInt ?? 0 < $1.dateInt ?? 0}
                for (key,jog) in jogs.enumerated() {
                    if key < jogs.count - 7 {
                        let week = jogs[key...key+7].filter {return calendar.isDate($0.date ?? Date(), equalTo: jog.date ?? Date(), toGranularity: .weekOfYear)}
                        weeks.append(week)
                        weeks = Array(Set(weeks))
                    }
                }
            }
            for week in weeks {
                let report = WeekReport(jogs: week)
                self?.reports.append(report)
            }
            handler(nil)
        }
    }
    
    
    
}



