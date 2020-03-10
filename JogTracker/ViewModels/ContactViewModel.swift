//
//  ContactViewModel.swift
//  JogTracker
//
//  Created by Ольга Бычок on 10/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

class ContactViewModel {
    
    func sendFeedback(text: String, title: String, handler: @escaping Handler) {
        NetworkManager.shared.sendFeedback(title: title, text: text, with: handler)
    }
    
}
