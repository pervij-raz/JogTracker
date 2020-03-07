//
//  NetworkManager.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private var loginURL: URL? {
        let urlString = "https://jogtracker.herokuapp.com/api/v1/auth/uuidLogin"
        return URL(string: urlString)
    }
    
    private init() {
    }
    
    func loginUser() {
        let id = UUID()
        guard let url = self.loginURL else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = "uuid=\(id.uuidString)".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
}
