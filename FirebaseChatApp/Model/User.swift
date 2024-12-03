//
//  User.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

public struct User: Identifiable, Codable, Hashable {
    
    public var id: String
    public var firstName: String?
    public var lastName: String?
    public var emailId: String?
    public var phoneNumber: String?
    public let loginType: LoginType
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case emailId = "email_id"
        case phoneNumber = "phone_number"
        case loginType = "login_type"
    }
}

public enum LoginType: String, Codable {
    case Apple = "apple"
    case Google = "google"
    case Phone = "phone"
}
