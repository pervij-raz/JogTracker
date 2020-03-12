//
//  ReportViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 10/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class ReportViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ReportViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.waiting()
        self.viewModel.filterJogs(handler: { _ in
            self.stopWaiting()
            self.tableView.reloadData()
        })
    }
    
    override func menuAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ReportViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell") as? ReportTableViewCell else {
            fatalError("Can't find cell")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? ReportTableViewCell)?.setup(with: self.viewModel.reports[indexPath.row], number: indexPath.row)
    }
    
    
}
