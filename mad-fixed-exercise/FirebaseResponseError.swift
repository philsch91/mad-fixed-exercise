//
//  FirebaseResponseError.swift
//  mad-fixed-exercise
//
//  Created by philipp on 27.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import Foundation

struct FirebaseReponseError: Decodable {
    let code: Int
    let message: String
    let status: String

    private enum RootCodingKeys: String, CodingKey {
        case error = "error"

        enum NestedCodingKeys: String, CodingKey {
            case code = "code"
            case message = "message"
            case status = "status"
        }
    }

    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let errorContainer = try rootContainer.nestedContainer(keyedBy: RootCodingKeys.NestedCodingKeys.self, forKey: FirebaseReponseError.RootCodingKeys.error)
        self.code = try errorContainer.decode(Int.self, forKey: FirebaseReponseError.RootCodingKeys.NestedCodingKeys.code)
        self.message = try errorContainer.decode(String.self, forKey: FirebaseReponseError.RootCodingKeys.NestedCodingKeys.message)
        self.status = try errorContainer.decode(String.self, forKey: FirebaseReponseError.RootCodingKeys.NestedCodingKeys.status)
    }
}
