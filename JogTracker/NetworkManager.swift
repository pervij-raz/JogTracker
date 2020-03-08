//
//  NetworkManager.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private var loginURL: URL? {
        return URL(string: "https://jogtracker.herokuapp.com/api/v1/auth/uuidLogin")
    }
    private var getUserURL: URL? {
        return URL(string: "https://jogtracker.herokuapp.com/api/v1/auth/user")
    }
    typealias Handler = (Error?) -> Void
    
    private init() {
    }
    
    func loginUser(with handler: @escaping Handler) {
        guard let url = self.loginURL else {return}
        let parametr = ["uuid": "hello"]
        AF.request(url, method: .post, parameters: parametr).responseJSON { response in
            switch response.result {
            case let .success(data):
                let json = data as? [String: Any]
                let response = json?["response"] as? [String: Any]
                guard let token = response?["access_token"] as? String, let type = response?["token_type"] as? String else {return}
                self.getUser(type: type, token: token, handler: handler)
            case let .failure(error):
                handler(error)
            }
        }
    }
    
    func getUser(type: String, token: String, handler: @escaping Handler) {
        guard let url = self.getUserURL else {return}
        let headers = HTTPHeaders(["Authorization": "\(type) \(token)"])
        AF.request(url, headers: headers)
            .responseJSON { response in
                switch response.result {
                case let .success(data):
                    handler(nil)
                case let .failure(error):
                    handler(error)
                }
        }
    }
    
}
