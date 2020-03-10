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
    
    private var filteredJogs: [Jog]? = nil
    
    var jogs: [Jog]? {
        if let jogs = self.filteredJogs {
            return jogs.sorted {$0.date ?? Date() < $1.date ?? Date()}
        } else {
            return allJogs?.sorted {$0.date ?? Date() < $1.date ?? Date()}
        }
    }
    
    func filterJogs(fromDate: Date, toDate: Date) {
        self.filteredJogs = jogs?.filter {
            if let date = $0.date {
                return date <= toDate && date >= fromDate
            }
            return false
        }
    }
    
}
