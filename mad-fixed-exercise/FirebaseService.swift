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
    
    //TODO: @escaping
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
        print(requestBody)
        urlRequest.httpBody = requestBody
        
        let dataTask = self.urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            guard let response = urlResponse as? HTTPURLResponse, error == nil else {
                print("error", error ?? "unknown error")
                return
            }
            
            print(response.statusCode)

            guard let data = data else {
                print("empty response body")
                return
            }

            let payload = String(data: data, encoding: String.Encoding.utf8)!
            print(payload)

            guard response.statusCode >= 200 && response.statusCode <= 299 else {
                let responseError = try! JSONDecoder().decode(ResponseError.self, from: data)
                print(responseError)
                return
            }

            let user = try! JSONDecoder().decode(User.self, from: data)
            print(user)
            
            if let completionHandler = completionHandler {
                completionHandler()
            }
        }
        
        dataTask.resume()
    }
}
