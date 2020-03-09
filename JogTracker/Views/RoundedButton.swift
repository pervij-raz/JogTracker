//
//  RoundedButton.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    private let babyPurpleColor = UIColor(red:0.91, green:0.56, blue:0.98, alpha:1.0)

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 3
        layer.borderColor = self.babyPurpleColor.cgColor
        layer.cornerRadius = frame.height / 2
    }

}
