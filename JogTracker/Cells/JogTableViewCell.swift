//
//  JogTableViewCell.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class JogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setup(with jog: Jog) {
        dateLabel.text = jog.date
        speedLabel.text = String(jog.speed)
        distanceLabel.text = "\(jog.distance ?? 0) km"
        timeLabel.text = "\(jog.time ?? 0) min"
    }
    
}
