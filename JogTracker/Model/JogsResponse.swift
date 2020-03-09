//
//  JogsResponse.swift
//  JogTracker
//
//  Created by Ольга Бычок on 08/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

struct JogsResponse: Decodable {
    
    var jogs: [Jog]
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    enum ResponseCodingKeys: String, CodingKey {
        case jogs
        case users
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: ResponseCodingKeys.self, forKey: .response)
        self.jogs = try response.decode([Jog].self, forKey: .jogs)
    }
}
