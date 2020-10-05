//
//  FirebaseService.swift
//  mad-fixed-exercise
//
//  Created by philipp on 05.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import Foundation

class FirebaseService {
    
    private let urlSession: URLSession
    private let apiKey = "AIzaSyCTryhlVmmRHYE7iQT3k0eeNRHIKsTMpRw"
    
    init(_ urlSessionConfiguration: URLSessionConfiguration) {
        self.urlSession = URLSession(configuration: urlSessionConfiguration)
    }
    
    convenience init() {
        self.init(URLSessionConfiguration.default)
    }
    
    func login(email: String, password: String, completionHandler: (() -> Void)?) -> Void {
        let url = URL(string: "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + self.apiKey)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var dict = [String: Any]()
        dict["email"] = email
        dict["password"] = password
        dict["returnSecureToken"] = true
        
        let requestBody = try! JSONSerialization.data(withJSONObject: dict, options: [])
        urlRequest.httpBody = requestBody
        
        let dataTask = self.urlSession.dataTask(with: urlRequest) { (_data, _urlResponse, _error) in
            guard let data = _data else {
                print(_urlResponse!)
                print(_error!)
                return
            }
            
            //let payload = String(data: data, encoding: String.Encoding.utf8)!
            //print(payload)
            let user = try! JSONDecoder().decode(User.self, from: data)
            print(user)
            
            if let _completionHandler = completionHandler {
                _completionHandler()
            }
        }
        
        dataTask.resume()
    }
}
