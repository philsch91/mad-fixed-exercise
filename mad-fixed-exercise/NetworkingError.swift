//
//  NetworkingError.swift
//  mad-fixed-exercise
//
//  Created by philipp on 05.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case requestSerialization
    case invalidEmailAddress
    case wrongEmailAddress
    case wrongPassword
    case networkOffline
    case responseSerialization
    case statusCode
    case unknown
}
