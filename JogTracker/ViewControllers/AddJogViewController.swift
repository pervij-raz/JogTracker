//
//  AddJogViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class AddJogViewController: BaseViewController {
    
    var viewModel = AddViewModel()
    
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    override func viewDidLoad() {
        self.bannerView.withFilter = true
        self.bannerView.activeFilter = false
        super.viewDidLoad()
        self.bannerView.filterButton.addTarget(self, action: #selector(popToList), for: .touchUpInside)
        setupForm()
    }
    
    @IBAction func closeForm(_ sender: UIButton) {
        self.popToList()
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if let distance = Float(distanceTextField.text ?? ""), let time = Int(timeTextField.text ?? ""), let date = dateTextField.text {
            let jog = Jog(id: self.viewModel.jog?.id, distance: distance, time: time, date: date)
            if jog.equals(compareTo: self.viewModel.jog) {
                self.showMessage(title: "Something went wrong", error: "One or more required inputs have not been modified or are empty")
            } else {
                self.waiting()
                self.viewModel.addOrUpdate(jog: jog, handler: self.handler)
            }
        } else {
            self.showMessage(title: "Something went wrong", error: "One or more required inputs have not been modified or are empty")
        }
    }
    
    override func menuAction() {
        self.dismiss(animated: true, completion: {self.goBack()})
    }
    
    override func navigateToNextController() {
        self.dismiss(animated: true, completion: {
            self.showSuccess()
        })
    }
    
    private func showSuccess() {
        if let window = UIApplication.shared.delegate?.window {
            if var viewController = window?.rootViewController {
                if (viewController is UINavigationController) {
                    viewController = (viewController as? UINavigationController)?.visibleViewController ?? UIViewController()
                }
                (viewController as? JogsViewController)?.showMessage(title: "", error: "Jog is saved")
            }
        }
    }
    
    @objc private func popToList() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupForm() {
        if let jog = self.viewModel.jog {
            self.distanceTextField.text = "\(jog.distance ?? 0)"
            self.timeTextField.text = "\(jog.time ?? 0)"
            if let date = jog.date {
                self.dateTextField.text = formatter.string(from: date)
            }
        }
    }
    
}
