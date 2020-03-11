//
//  JogsViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class JogsViewController: BaseViewController, UITableViewDelegate {
    
    // MARK: Properties
    
    private var activeTextField: UITextField?
    private var viewModel = JogsViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    lazy private var headerCell: JogHeaderTableViewCell = {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Header") as! JogHeaderTableViewCell
        return cell
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        self.waiting()
        self.viewModel.getJogs(handler: { _ in
            self.stopWaiting()
            self.tableView.reloadData()
        })
        self.bannerView.withFilter = true
        self.bannerView.activeFilter = true
        super.viewDidLoad()
        self.bannerView.filterButton.addTarget(self, action: #selector(openNewJog), for: .touchUpInside)
        self.createDatePicker(forField: self.headerCell.fromTextField)
        self.createDatePicker(forField: self.headerCell.toTextField)
    }
    
    // MARK: Helpers
    
    @objc private func openNewJog() {
        self.openAddNewJog()
    }
    
    // MARK: Overrides
    
    override func menuAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

	// MARK: UITextFieldDelegate

extension JogsViewController: UITextFieldDelegate {
    
    private func createDatePicker(forField field : UITextField){
        field.delegate = self
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.date = formatter.date(from: field.text ?? "") ?? Date()
        field.inputView = picker
        picker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem:.done, target: nil, action: #selector(pickerDonePressed))
        toolbar.setItems([done], animated: false)
        field.inputAccessoryView = toolbar
    }
    
    @objc private func datePickerValueChanged(sender: UIDatePicker) {
        activeTextField?.text = formatter.string(from: sender.date)
    }
    
    @objc private func pickerDonePressed() {
        self.view.endEditing(true)
        if let toText = self.headerCell.toTextField.text, let fromText = self.headerCell.fromTextField.text {
            guard let fromDate = formatter.date(from: fromText), let toDate = formatter.date(from: toText) else {return}
            self.viewModel.filterJogs(fromDate: fromDate, toDate: toDate)
            self.tableView.reloadData()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
}

	// MARK: UITableViewDataSource


extension JogsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel.jogs?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < self.viewModel.jogs?.count ?? 0 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as? JogTableViewCell else {
                fatalError("Can't find cell")
            }
            guard let jogs = self.viewModel.jogs else {return cell}
            cell.setup(with: jogs[indexPath.row])
            return cell
        } else {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "AddCell") else {
                fatalError("Can't find cell")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerCell.contentView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < self.viewModel.jogs?.count ?? 0 {
            self.openAddNewJog(withJog: self.viewModel.jogs?[indexPath.row])
        } else {
            self.openAddNewJog()
        }
    }
    
}

