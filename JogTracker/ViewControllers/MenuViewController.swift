//
//  MenuViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class MenuViewController: ViewController {
    
    // MARK: Properties
    
    private let viewModel = MenuViewModel()
    private var isReportLoading: Bool = false
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Buttons
    
    @IBAction func closeButton(_ sender: UIButton) {
        logout()
        let vc = storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as? UINavigationController
        guard let appDelegate:AppDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        appDelegate.centerContainer?.centerViewController = vc
    }
    
    @IBAction func jogsButton(_ sender: UIButton) {
        self.openLists()
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        guard let infoVC = storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController else {return}
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    @IBAction func reportButton(_ sender: UIButton) {
        self.isReportLoading = true
        self.openLists()
    }
    
    private func openLists() {
        if let _ = UserData.shared.id {
            if UserData.shared.jogs != nil {
                handler(nil)
            } else {
                self.waiting()
                self.viewModel.getJogs(with: self.handler)
            }
        } else {
            self.showMessage(title: "You are not authorised", error: "For jogs adding please press × and then 'Let me in' button" )
        }
    }
    
    // MARK: Helpers
    
    private func logout() {
        let domain = Bundle.main.bundleIdentifier ?? ""
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        UserData.shared.jogs = nil
    }
    
    private func openReport() {
        guard let reportVC  = storyboard?.instantiateViewController(withIdentifier: "ReportViewController") as? ReportViewController else {return}
        self.navigationController?.pushViewController(reportVC, animated: true)
    }
    
    private func openEmptyList() {
        guard let emptyVC  = storyboard?.instantiateViewController(withIdentifier: "EmptyViewController") as? EmptyViewController else {return}
        self.navigationController?.pushViewController(emptyVC, animated: true)
    }
    
    private func openJogs() {
        guard let listVC  = storyboard?.instantiateViewController(withIdentifier: "JogsViewController") as? JogsViewController else {return}
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
    // MARK: Overrides
    
    override func navigateToNextController() {
        if self.isReportLoading {
            self.openReport()
        } else {
            if viewModel.jogs?.isEmpty ?? true {
                self.openEmptyList()
            } else {
                self.openJogs()
            }
        }
    }
    
}
