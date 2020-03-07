//
//  JogsViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class JogsViewController: BaseViewController, UITableViewDelegate {
    
    private var viewModel = JogsViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    
    lazy private var headerCell: JogHeaderTableViewCell = {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Header") as! JogHeaderTableViewCell
        return cell
    }()
    
    override func viewDidLoad() {
        self.bannerView.withFilter = true
        super.viewDidLoad()
    }
    
}

extension JogsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.jogs.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < self.viewModel.jogs.count {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as? JogTableViewCell else {
            fatalError("Can't find cell with id: sortCellID")
        }
        cell.setup(with: self.viewModel.jogs[indexPath.row])
            return cell
        } else {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "AddCell") as? AddJogTableViewCell else {
                fatalError("Can't find cell with id: sortCellID")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerCell
    }
    
}

