//
//  WelcomeViewModel.swift
//  JogTracker
//
//  Created by Ольга Бычок on 08/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

class WelcomeViewModel {
    
    func login(with handler: @escaping WelcomeHandler) {
        NetworkManager.shared.loginUser(with: handler)
    }
    
}
