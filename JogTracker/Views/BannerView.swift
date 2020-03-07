//
//  BannerView.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class BannerView: UIView {
    
    let menuButton = UIButton()
    private let logoImageView = UIImageView()
    private let filterButton = UIButton()
    var withFilter: Bool = false
    
    override func updateConstraints() {
        super.updateConstraints()
        self.doLayout()
    }
    
    func setupSubviews() {
        self.addSubview(self.menuButton)
        self.addSubview(self.logoImageView)
        self.menuButton.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.menuButton.setImage(UIImage(named: "menu"), for: .normal)
        self.logoImageView.image = UIImage(named: "logoWhite")
        if withFilter {
            self.addSubview(self.filterButton)
            self.filterButton.translatesAutoresizingMaskIntoConstraints = false
            self.filterButton.setImage(UIImage(named: "filterActive"), for: .normal)
        }
    }
    
    func doLayout() {
        NSLayoutConstraint(item: self.menuButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: (-25.0)).isActive = true
        NSLayoutConstraint(item: self.menuButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.menuButton, attribute: .width, relatedBy: .equal,
                           toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 28).isActive = true
        NSLayoutConstraint(item: self.menuButton, attribute: .height, relatedBy: .equal,
                           toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 24).isActive = true
        
        NSLayoutConstraint(item: self.logoImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 25.0).isActive = true
        NSLayoutConstraint(item: self.logoImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.logoImageView, attribute: .width, relatedBy: .equal,
                           toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 98).isActive = true
        NSLayoutConstraint(item: self.logoImageView, attribute: .height, relatedBy: .equal,
                           toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 37).isActive = true
        if withFilter {
        NSLayoutConstraint(item: self.filterButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: (-92)).isActive = true
        NSLayoutConstraint(item: self.filterButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: (18)).isActive = true
        }
    }
    
    
}
