//
//  MenuViewModel.swift
//  JogTracker
//
//  Created by Ольга Бычок on 08/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

class MenuViewModel {
    
    var jogs: [Jog]? {
        return UserData.shared.jogs
    }
    
    func getJogs(with handler: @escaping Handler) {
        NetworkManager.shared.getJogs(with: handler)
    }
    
}
