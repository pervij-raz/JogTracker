//
//  LeftSideMenuController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 10/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class LeftSideMenuController: ViewController {

    @IBAction func contactButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let contactUsViewController = storyboard.instantiateViewController(withIdentifier: "ContactUs") as? ContactUsViewController
        guard let appDelegate:AppDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        appDelegate.centerContainer?.centerViewController = contactUsViewController
        appDelegate.centerContainer?.toggle(.left, animated: true, completion: nil)
    }
    
    @IBAction func MenuButton(_ sender: UIButton) {
        self.openMainMenu()
    }
    
}
