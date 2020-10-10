//
//  ResponseError.swift
//  mad-fixed-exercise
//
//  Created by philipp on 07.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import Foundation

struct ResponseError: Decodable {
    let code: Int
    let message: String
    let errors: [NestedResponseError]

    private enum RootCodingKeys: String, CodingKey {
        case error = "error"

        enum RootNestedCodingKeys: String, CodingKey {
            case code = "code"
            case message = "message"
            case errors = "errors"

            enum NestedCodingKeys: String, CodingKey {
                case message = "message"
                case domain = "domain"
                case reason = "reason"
            }
        }
    }

    struct NestedResponseError: Decodable {
        let message: String
        let domain: String
        let reason: String

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: RootCodingKeys.RootNestedCodingKeys.NestedCodingKeys.self)
            self.message = try container.decode(String.self, forKey: RootCodingKeys.RootNestedCodingKeys.NestedCodingKeys.message)
            self.domain = try container.decode(String.self, forKey: RootCodingKeys.RootNestedCodingKeys.NestedCodingKeys.domain)
            self.reason = try container.decode(String.self, forKey: RootCodingKeys.RootNestedCodingKeys.NestedCodingKeys.reason)
        }
    }

    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let rootErrorContainer = try rootContainer.nestedContainer(keyedBy: RootCodingKeys.RootNestedCodingKeys.self, forKey: ResponseError.RootCodingKeys.error)

        self.code = try rootErrorContainer.decode(Int.self, forKey: ResponseError.RootCodingKeys.RootNestedCodingKeys.code) //remove ResponseError
        self.message = try rootErrorContainer.decode(String.self, forKey: ResponseError.RootCodingKeys.RootNestedCodingKeys.message)

        var nestedErrors = try rootErrorContainer.nestedUnkeyedContainer(forKey: RootCodingKeys.RootNestedCodingKeys.errors)

        var errors = [NestedResponseError]()

        while !nestedErrors.isAtEnd {
            let error = try nestedErrors.decode(NestedResponseError.self)
            errors.append(error)
        }

        self.errors = errors
    }
}
