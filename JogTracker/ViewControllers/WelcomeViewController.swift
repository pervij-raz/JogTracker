//
//  WelcomeViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.waiting()
        NetworkManager.shared.loginUser(with: {error in
            if let error = error {
                self.showError(error.localizedDescription)
            } else {
                self.menuAction()
            }
        })
    }
    
}

