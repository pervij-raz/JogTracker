//
//  ContactUsViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 10/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class ContactUsViewController: BaseViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textTextField: UITextView!
    
    let viewModel = ContactViewModel()

    @IBAction func sendMessageButton(_ sender: UIButton) {
        self.viewModel.sendFeedback(text: textTextField.text ?? "", title: titleTextField.text ?? "", handler: self.handler)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bannerView.menuButton.isHidden = true
    }
    
    override func navigateToNextController() {
        self.showMessage(title: "", error: "Your message is succesfully sent", withHandler: { () in
            self.openMainMenu()
        })
    }
    
}
