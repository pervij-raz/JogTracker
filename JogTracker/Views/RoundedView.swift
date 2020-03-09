//
//  RoundedView.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 20
    }
}
