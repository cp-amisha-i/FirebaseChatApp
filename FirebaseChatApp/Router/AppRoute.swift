//
//  AppRoute.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

enum AppRoute: Hashable {
    
    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        return lhs.key == rhs.key
    }
    
    case LoginView
    case PhoneLoginView
    case OTPView(phoneNumber: String, dialCode: String, verificationId: String)
    case HomeView
    
    var key: String {
        switch self {
        case .LoginView:
            "LoginView"
        case .HomeView:
            "HomeView"
        case .PhoneLoginView:
            "PhoneLoginView"
        case .OTPView:
            "OTPView"
        }
    }
}
