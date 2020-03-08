//
//  AddJogViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class AddJogViewController: BaseViewController {

    @IBAction func closeForm(_ sender: UIButton) {
        self.popToList()
    }
    
    @objc private func popToList() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        self.bannerView.withFilter = true
        self.bannerView.activeFilter = false
        super.viewDidLoad()
        self.bannerView.filterButton.addTarget(self, action: #selector(popToList), for: .touchUpInside)
    }

}
