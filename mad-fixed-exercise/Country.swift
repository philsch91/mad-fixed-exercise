//
//  Country.swift
//  mad-fixed-exercise
//
//  Created by philipp on 26.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import Foundation

struct DocumentsContainer: Decodable {
    var documents: [Country]
}

struct Country: Decodable {
    var ID: String
    var name: String
    var languages: [String]
    var currency: String
    var capital: String
    var native: String
    var continent: String
    var phone: String
    var createTime: Date
    var updateTime: Date

    private enum RootCodingKeys: String, CodingKey {
        case name = "name"
        case fields = "fields"
        case createTime = "createTime"
        case updateTime = "updateTime"

        enum FieldsCodingKeys: String, CodingKey {
            case name = "name"
            case languages = "languages"
            case currency = "currency"
            case capital = "capital"
            case native = "native"
            case continent = "continent"
            case phone = "phone"

            enum StringValueCodingKeys: String, CodingKey {
                case stringValue = "stringValue"
            }

            enum ArrayValueCodingKeys: String, CodingKey {
                case arrayValue = "arrayValue"

                enum ArrayValueValuesCodingKeys: String, CodingKey {
                    case values = "values"
                }
            }
        }
    }

    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)

        self.ID = (try rootContainer.decode(String.self, forKey: RootCodingKeys.name) as NSString).lastPathComponent
        self.createTime = try rootContainer.decode(Date.self, forKey: RootCodingKeys.createTime)
        self.updateTime = try rootContainer.decode(Date.self, forKey: RootCodingKeys.updateTime)

        // fields
        let fieldsContainer = try rootContainer.nestedContainer(keyedBy: RootCodingKeys.FieldsCodingKeys.self, forKey: RootCodingKeys.fields)

        // name
        let nameStringContainer = try fieldsContainer.nestedContainer(keyedBy: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.self, forKey: RootCodingKeys.FieldsCodingKeys.name)
        self.name = try nameStringContainer.decode(String.self, forKey: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.stringValue)
        // languages
        let languagesContainer = try fieldsContainer.nestedContainer(keyedBy: RootCodingKeys.FieldsCodingKeys.ArrayValueCodingKeys.self, forKey: Country.RootCodingKeys.FieldsCodingKeys.languages)
        let languagesArrayValueContainer = try languagesContainer.nestedContainer(keyedBy: RootCodingKeys.FieldsCodingKeys.ArrayValueCodingKeys.ArrayValueValuesCodingKeys.self, forKey: Country.RootCodingKeys.FieldsCodingKeys.ArrayValueCodingKeys.arrayValue)
        var languagesArrayValueValueContainer = try languagesArrayValueContainer.nestedUnkeyedContainer(forKey: Country.RootCodingKeys.FieldsCodingKeys.ArrayValueCodingKeys.ArrayValueValuesCodingKeys.values)

        var languages = [String]()

        while !languagesArrayValueValueContainer.isAtEnd {
            let langauageStringContainer = try languagesArrayValueValueContainer.nestedContainer(keyedBy: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.self)
            let language = try langauageStringContainer.decode(String.self, forKey: Country.RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.stringValue)
            languages.append(language)
        }

        self.languages = languages

        // currency
        let currencyStringContainer = try fieldsContainer.nestedContainer(keyedBy: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.self, forKey: RootCodingKeys.FieldsCodingKeys.currency)
        self.currency = try currencyStringContainer.decode(String.self, forKey: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.stringValue)
        // capital
        let capitalStringContainer = try fieldsContainer.nestedContainer(keyedBy: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.self, forKey: RootCodingKeys.FieldsCodingKeys.currency)
        self.capital = try capitalStringContainer.decode(String.self, forKey: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.stringValue)
        // native
        let nativeStringContainer = try fieldsContainer.nestedContainer(keyedBy: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.self, forKey: RootCodingKeys.FieldsCodingKeys.native)
        self.native = try nativeStringContainer.decode(String.self, forKey: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.stringValue)
        // continent
        let continentStringContainer = try fieldsContainer.nestedContainer(keyedBy: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.self, forKey: RootCodingKeys.FieldsCodingKeys.continent)
        self.continent = try continentStringContainer.decode(String.self, forKey: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.stringValue)
        // phone
        let phoneStringContainer = try fieldsContainer.nestedContainer(keyedBy: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.self, forKey: RootCodingKeys.FieldsCodingKeys.phone)
        self.phone = try phoneStringContainer.decode(String.self, forKey: RootCodingKeys.FieldsCodingKeys.StringValueCodingKeys.stringValue)
    }
}
