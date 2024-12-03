//
//  Country.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 02/12/24.
//

import Foundation

struct Country: Codable, Identifiable {
    let id = UUID().uuidString
    let name: String
    let dialCode: String
    let isoCode: String

    init(name: String, dialCode: String, isoCode: String) {
        self.name = name
        self.dialCode = dialCode
        self.isoCode = isoCode
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dialCode = "dial_code"
        case isoCode = "code"
    }

    var flag: String {
        return String(String.UnicodeScalarView(
            isoCode.unicodeScalars.compactMap({ UnicodeScalar(127397 + $0.value) })))
    }
}
