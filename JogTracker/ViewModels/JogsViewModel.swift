//
//  JogsViewModel.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

class JogsViewModel {
    
    var jogs: [Jog]? {
        return UserData.shared.jogs
    }
    
}
