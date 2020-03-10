//
//  NetworkManager.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import Foundation
import Alamofire

public typealias Handler = (Error?) -> Void

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var loginURL: URL? {
        return URL(string: "https://jogtracker.herokuapp.com/api/v1/auth/uuidLogin")
    }
    
    private var getUserURL: URL? {
        return URL(string: "https://jogtracker.herokuapp.com/api/v1/auth/user")
    }
    
    private var getJogsURL: URL? {
        return URL(string: "https://jogtracker.herokuapp.com/api/v1/data/sync")
    }
    
    private var jogURL: URL? {
        return URL(string: "https://jogtracker.herokuapp.com/api/v1/data/jog")
    }
    
    private var feedbackURL: URL? {
        return URL(string: "https://jogtracker.herokuapp.com/api/v1/feedback/send")
    }
    
    private var type: String? {
        get {
            return UserDefaults.standard.string(forKey: "type")
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "type")
        }
    }
    
    private var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "token")
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
    
    private var headers: HTTPHeaders? {
        if let type = type, let token = token {
            return HTTPHeaders(["Authorization": "\(type) \(token)"])
        } else {
            return nil
        }
    }
    
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
                self.token = token
                self.type = type
                self.getUser(type: type, token: token, handler: handler)
            case let .failure(error):
                handler(error)
            }
        }
    }
    
    func getUser(type: String, token: String, handler: @escaping Handler) {
        guard let url = self.getUserURL else {return}
        AF.request(url, method: .get, headers: self.headers)
            .responseJSON { response in
                switch response.result {
                case let .success(data):
                    let json = data as? [String: Any]
                    let responce = json?["response"] as? [String: Any]
                    UserData.shared.id = responce?["id"] as? String
                    handler(nil)
                case let .failure(error):
                    handler(error)
                }
        }
    }
    
    func getJogs(with handler: @escaping Handler) {
        guard let url = self.getJogsURL else {return}
        AF.request(url, method: .get, headers: self.headers).response { response in
            switch response.result {
            case .success:
                guard let data = response.data else {return}
                let json = try? JSONDecoder().decode(JogsResponse.self, from: data)
                UserData.shared.jogs = json?.jogs.filter{$0.userID == UserData.shared.id}
                handler(nil)
            case let .failure(error):
                handler(error)
            }
        }
    }
    
    func addJog(_ jog: Jog, with handler: @escaping Handler) {
        guard let url = self.jogURL else {return}
        let parametr = jog.jogForRequestBody
        AF.request(url, method: .post, parameters: parametr, headers: self.headers).response { response in
            switch response.result {
            case .success:
                handler(nil)
            case let .failure(error):
                handler(error)
            }
        }
    }
    
    func updateJog(_ jog: Jog, with handler: @escaping Handler) {
        guard let url = self.jogURL else {return}
        let parametr = jog.jogForRequestBody
        AF.request(url, method: .put, parameters: parametr, headers: self.headers).response { response in
            switch response.result {
            case .success:
                handler(nil)
            case let .failure(error):
                handler(error)
            }
        }
    }
    
    func sendFeedback(title: String, text: String, with handler: @escaping Handler) {
        guard let url = self.feedbackURL else {return}
        let parametr: [String: Any] = ["topic_id": 1, "text": text, "topic": title]
        AF.request(url, method: .post, parameters: parametr, headers: self.headers).response { response in
            switch response.result {
            case .success:
                handler(nil)
            case let .failure(error):
                handler(error)
            }
        }
                
        
    }
}
