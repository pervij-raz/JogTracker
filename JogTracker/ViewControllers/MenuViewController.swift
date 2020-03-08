//
//  MenuViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func jogsButton(_ sender: UIButton) {
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
    }
    
    @IBAction func contactUsButton(_ sender: UIButton) {
    }
    
}
