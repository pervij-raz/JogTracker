//
//  JogsViewModel.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

class JogsViewModel {
    
    private var allJogs: [Jog]? {
        return UserData.shared.jogs
    }
    
    var jogs: [Jog]?
    
    private var filteredJogs: [Jog]? = nil
    
    func getJogs( handler: @escaping Handler) {
        DispatchQueue.main.async { [weak self] in
            if let jogs = self?.filteredJogs {
                self?.jogs = jogs.sorted {$0.date ?? Date() < $1.date ?? Date()}
            } else {
                self?.jogs = self?.allJogs?.sorted {$0.date ?? Date() < $1.date ?? Date()}
            }
            handler(nil)
        }
    }
    
    func filterJogs(fromDate: Date, toDate: Date) {
        self.filteredJogs = allJogs?.filter {
            if let date = $0.date {
                return date <= toDate && date >= fromDate
            }
            return false
        }
    }
    
}
