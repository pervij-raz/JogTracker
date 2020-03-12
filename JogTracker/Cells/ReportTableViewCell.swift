//
//  ReportTableViewCell.swift
//  JogTracker
//
//  Created by Ольга Бычок on 10/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    func setup(with report: WeekReport, number: Int) {
        self.dateLabel.text = "Week \(number): (\(formatter.string(from: report.fromDate ?? Date())) / \(formatter.string(from: report.toDate ?? Date())))"
        self.distanceLabel.text = "Total distance: \(report.totalDistance ?? 0)"
        self.speedLabel.text = "Average speed: \(report.averageSpeed ?? 0)"
        self.timeLabel.text = "Average time: \(report.averageTime ?? 0)"
    }

}
