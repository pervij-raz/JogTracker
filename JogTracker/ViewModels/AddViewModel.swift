//
//  AddViewModel.swift
//  JogTracker
//
//  Created by Ольга Бычок on 09/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

class AddViewModel {
    
    var jog: Jog? = nil
    var newJog: Jog? = nil
    
    func addOrUpdate(jog: Jog, handler: @escaping Handler) {
        self.newJog = jog
        if self.jog == nil {
            NetworkManager.shared.addJog(jog, with: handler)
        } else if self.jog != jog {
            NetworkManager.shared.updateJog(jog, with: handler)
        } else {
            
        }
    }
    
}
