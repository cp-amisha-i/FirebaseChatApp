//
//  SignInWithAppleDelegates.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

import AuthenticationServices

class SignInWithAppleDelegates: NSObject {

    private let signInSucceeded: (String, String, String, String) -> Void

    init(signInSucceeded: @escaping (String, String, String, String) -> Void) {
        self.signInSucceeded = signInSucceeded
    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            guard let appleIDToken = appleIDCredential.identityToken else {
                print("SignInWithAppleDelegates: \(#function) Unable to fetch identity token.")
                return
            }

            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("SignInWithAppleDelegates: \(#function) Unable to serialize token string from data: \(appleIDToken.debugDescription).")
                return
            }

            let firstName = appleIDCredential.fullName?.givenName ?? ""
            let lastName = appleIDCredential.fullName?.familyName ?? ""
            let email = appleIDCredential.email ?? ""

            self.signInSucceeded(idTokenString, firstName, lastName, email)
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("SignInWithAppleDelegates: \(#function) Apple login complete with error: \(error).")
    }
}
