//
//  AddJogViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class AddJogViewController: BaseViewController {
    
    // MARK: Properies
    
    var viewModel = AddViewModel()
    
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        self.bannerView.withFilter = true
        self.bannerView.activeFilter = false
        super.viewDidLoad()
        self.bannerView.filterButton.addTarget(self, action: #selector(popToList), for: .touchUpInside)
        setupForm()
        setupDatePicker()
    }
    
    // MARK: Buttons
    
    @IBAction func closeForm(_ sender: UIButton) {
        self.popToList()
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        self.view.endEditing(true)
        if let distance = Float(distanceTextField.text ?? ""), let time = Int(timeTextField.text ?? ""), let date = dateTextField.text {
            let jog = Jog(id: self.viewModel.jog?.id, distance: distance, time: time, date: date)
            if jog.equals(compareTo: self.viewModel.jog) {
                self.inputsNotFilled()
            } else {
                self.waiting()
                self.viewModel.addOrUpdate(jog: jog, handler: self.handler)
            }
        } else {
            self.inputsNotFilled()
        }
    }
    
    // MARK: Overrides
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func menuAction() {
        self.dismiss(animated: true, completion: {self.goBack()})
    }
    
    override func navigateToNextController() {
        if let jogs = UserData.shared.jogs {
            if self.viewModel.jog == nil, let jog = self.viewModel.newJog {
                UserData.shared.jogs?.append(jog)
            } else {
                for (key, value) in jogs.enumerated() {
                    if value.id == self.viewModel.newJog?.id {
                        UserData.shared.jogs?[key] = self.viewModel.newJog ?? value
                    }
                }
            }
        }
        self.showSuccess()
    }
    
    // MARK: Helpers
    
    private func inputsNotFilled() {
        self.showMessage(title: "Something went wrong", error: "One or more required inputs have not been modified or are empty")
    }
    
    
    private func showSuccess() {
        self.showMessage(title: "", error: "Jog is saved", withHandler: {() in
            self.dismiss(animated: true, completion: nil)
        })
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
    
    @objc private func datePickerValueChanged(sender: UIDatePicker) {
        dateTextField.text = formatter.string(from: sender.date)
    }
    
    private func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        datePicker.date = self.viewModel.jog?.date ?? Date()
    }
    
}
