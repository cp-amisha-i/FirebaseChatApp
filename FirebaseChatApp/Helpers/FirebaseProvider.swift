//
//  FirebaseProvider.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

import FirebaseCore
import FirebaseAuth

public class FirebaseProvider {

    public static var auth: Auth = .auth()
    public static var phoneAuthProvider: PhoneAuthProvider = .provider()

    static public func configureFirebase() {
        FirebaseApp.configure()
    }
}
