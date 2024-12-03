//
//  AppPreference.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

import Foundation

@Observable
class AppPreference {

    enum Key: String {
        case isVerifiedUser = "is_verified_user"
        case user           = "user"
    }

    private let userDefaults: UserDefaults

    init() {
        self.userDefaults = UserDefaults.standard
        self.isVerifiedUser = userDefaults.bool(forKey: Key.isVerifiedUser.rawValue)
    }

    public var isVerifiedUser: Bool {
        didSet {
            userDefaults.set(isVerifiedUser, forKey: Key.isVerifiedUser.rawValue)
        }
    }

    public var user: User? {
        get {
            do {
                let data = userDefaults.data(forKey: Key.user.rawValue)
                if let data {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    return user
                }
            } catch let error {
                print("Preferences \(#function) json decode error: \(error).")
            }
            return nil
        } set {
            do {
                let data = try JSONEncoder().encode(newValue)
                userDefaults.set(data, forKey: Key.user.rawValue)
            } catch let error {
                print("Preferences \(#function) json encode error: \(error).")
            }
        }
    }

    public func clearPreferenceSession() {
        user = nil
        isVerifiedUser = false
    }
}
