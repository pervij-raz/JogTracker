//
//  MenuViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class MenuViewController: ViewController {
    
    private let viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func jogsButton(_ sender: UIButton) {
        if let _ = UserData.shared.id {
        self.waiting()
        self.viewModel.getJogs(with: self.handler)
        } else {
            self.showMessage(title: "You are not authorised", error: "For jogs adding please press × and then 'Let me in' button" )
        }
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        guard let infoVC = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController else {return}
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    @IBAction func reportButton(_ sender: UIButton) {
        
    }
    
    override func navigateToNextController() {
        if viewModel.jogs?.isEmpty ?? true {
            self.openEmptyList()
        } else {
            self.openList()
        }
    }
    
    private func openEmptyList() {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        guard let emptyVC  = storyboard.instantiateViewController(withIdentifier: "EmptyViewController") as? EmptyViewController else {return}
        self.navigationController?.pushViewController(emptyVC, animated: true)
    }
    
    private func openList() {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        guard let listVC  = storyboard.instantiateViewController(withIdentifier: "JogsViewController") as? JogsViewController else {return}
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
}
