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
    public var user: User?
    public var isAuthenticated: Bool {
        get {
            if self.user == nil {
                return false
            }
            return true
        }
    }
    
    init(_ urlSessionConfiguration: URLSessionConfiguration) {
        self.urlSession = URLSession(configuration: urlSessionConfiguration)
    }
    
    convenience init() {
        self.init(URLSessionConfiguration.default)
    }
    
    public func login(email: String, password: String, completionHandler: @escaping (User?, NetworkingError?) -> Void) -> Void {
        let url = URL(string: "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + self.apiKey)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var dict = [String: Any]()
        dict["email"] = email
        dict["password"] = password
        dict["returnSecureToken"] = true
        
        let requestBody: Data
        do {
            requestBody = try JSONSerialization.data(withJSONObject: dict, options: [])
        } catch {
            print(error)
            completionHandler(nil, NetworkingError.requestSerialization(error.localizedDescription))
            return
        }

        print(requestBody)
        urlRequest.httpBody = requestBody
        
        let dataTask = self.urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            guard let response = urlResponse as? HTTPURLResponse, error == nil else {
                print("error", error ?? "unknown error")
                var networkingError = NetworkingError.unknown("")

                if let error = error {
                    networkingError = self.mapErrorToNetworkingError(error)
                }

                completionHandler(nil, networkingError)
                return
            }
            
            print("status code: " + String(response.statusCode))

            guard let data = data else {
                print("empty response body")
                var networkingError = NetworkingError.unknown("")

                if response.statusCode != 200 {
                    networkingError = NetworkingError.statusCode(response.statusCode)
                }

                completionHandler(nil, networkingError)
                return
            }

            let payload = String(data: data, encoding: String.Encoding.utf8)!
            print(payload)

            //guard response.statusCode >= 200 && response.statusCode <= 299 else {
            if response.statusCode != 200 {
                let responseError: ResponseError
                do {
                    responseError = try JSONDecoder().decode(ResponseError.self, from: data)
                } catch {
                    print(error)
                    var networkingError = NetworkingError.statusCode(response.statusCode)

                    if (response.statusCode == 400) {
                        networkingError = NetworkingError.responseSerialization(error.localizedDescription)
                    }

                    completionHandler(nil, networkingError)
                    return
                }

                print(responseError)
                let error = self.mapResponseErrorToNetworkingError(responseError)
                completionHandler(nil, error)
                return
            }
            
            let user: User

            do {
                user = try JSONDecoder().decode(User.self, from: data)
            } catch {
                print(error)
                completionHandler(nil, NetworkingError.responseSerialization(error.localizedDescription))
                return
            }

            print(user)

            completionHandler(user, nil)
        }
        
        dataTask.resume()
    }

    public func getCountries(completionHandler: @escaping ([Country]?, NetworkingError?) -> Void) -> Void {
        guard let user = self.user else {
            return
        }
        let url = URL(string: "https://firestore.googleapis.com/v1/projects/mad-course-3ceb1/databases/(default)/documents/countries?pageSize=1000&orderBy=name")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(user.idToken)", forHTTPHeaderField: "Authorization")

        let dataTask = self.urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            guard let response = urlResponse as? HTTPURLResponse, error == nil else {
                print("error", error ?? "unknown error")
                var networkingError = NetworkingError.unknown("")

                if let error = error {
                    networkingError = self.mapErrorToNetworkingError(error)
                }

                completionHandler(nil, networkingError)
                return
            }

            print("status code: " + String(response.statusCode))

            guard let data = data else {
                print("empty response body")
                var networkingError = NetworkingError.unknown("")

                if response.statusCode != 200 {
                    networkingError = NetworkingError.statusCode(response.statusCode)
                }

                completionHandler(nil, networkingError)
                return
            }

            //let payload = String(data: data, encoding: String.Encoding.utf8)!
            //print(payload)

            guard response.statusCode == 200 else {
                // TODO
                return
            }

            let documentsContainer: DocumentsContainer

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.formatted(DateFormatter.iso8601Full)
                documentsContainer = try decoder.decode(DocumentsContainer.self, from: data)
            } catch {
                print(error)
                completionHandler(nil, NetworkingError.responseSerialization(error.localizedDescription))
                return
            }

            //print(documentsContainer.documents)

            completionHandler(documentsContainer.documents, nil)
        }

        dataTask.resume()
    }

    func mapErrorToNetworkingError(_ error: Error) -> NetworkingError {
        let error = (error as NSError)
        print("error.code: \(error.code)")
        print("error.domain: \(error.domain)")
        print("error.description: \(error.description)")

        if error.code == -1009 && error.domain == "NSURLErrorDomain" {
            return NetworkingError.networkOffline(error.localizedDescription)
        }

        //error.localizedDescription
        return NetworkingError.unknown("")
    }

    func mapResponseErrorToNetworkingError(_ error: ResponseError) -> NetworkingError {
        switch error.message {
        case "INVALID_EMAIL":
            return NetworkingError.invalidEmailAddress(error.message)
        case "EMAIL_NOT_FOUND":
            return NetworkingError.wrongEmailAddress(error.message)
        case "INVALID_PASSWORD":
            return NetworkingError.wrongPassword(error.message)
        case "TOO_MANY_ATTEMPTS_TRY_LATER":
            return NetworkingError.wrongPassword(error.message)
        default:
            return NetworkingError.unknown("")
        }
    }
}
