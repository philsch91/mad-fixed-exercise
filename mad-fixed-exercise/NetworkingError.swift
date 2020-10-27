//
//  NetworkingError.swift
//  mad-fixed-exercise
//
//  Created by philipp on 05.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case requestSerialization(String)
    case invalidEmailAddress(String)
    case wrongEmailAddress(String)
    case wrongPassword(String)
    case networkOffline(String)
    case responseSerialization(String)
    case forbidden(String)
    case statusCode(Int)
    case unknown(String)

    func get() -> String {
        switch self {
        case NetworkingError.requestSerialization(let str):
            return str
        case NetworkingError.invalidEmailAddress(let str):
            return str
        case NetworkingError.wrongEmailAddress(let str):
            return str
        case NetworkingError.wrongPassword(let str):
            return str
        case NetworkingError.networkOffline(let str):
            return str
        case NetworkingError.responseSerialization(let str):
            return str
        case NetworkingError.forbidden(let str):
            return str
        case NetworkingError.statusCode(let int):
            return String(int)
        case NetworkingError.unknown(let str):
            return str
        }
    }
}
