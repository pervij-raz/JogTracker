//
//  WelcomeViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    private let viewModel = WelcomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserData.shared.id != nil {
          self.login()
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.login()
    }
    
    private func login() {
        self.waiting()
        self.viewModel.login(with: self.handler)
    }
    
}

