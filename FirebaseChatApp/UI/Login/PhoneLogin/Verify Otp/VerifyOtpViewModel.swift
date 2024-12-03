//
//  VerifyOtpViewModel.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 02/12/24.
//

import Combine
import SwiftUI
import FirebaseAuth

@Observable
class VerifyOtpViewModel: BaseViewModel {

    var preference: AppPreference

    var otp = ""
    var resendOtpCount: Int = 30
    private(set) var showLoader: Bool = false
    private(set) var resendTimer: Timer?

    var hiddenPhoneNumber: String {
        let count = phoneNumber.count
        guard count > 4 else { return phoneNumber }
        let middleNumbers = String(repeating: "*", count: count - 4)
        return "\(phoneNumber.prefix(2))\(middleNumbers)\(phoneNumber.suffix(2))"
    }

    private let router: Router<AppRoute>?
    private let dialCode: String
    private var phoneNumber: String
    private var verificationId: String
    private var isFromPhoneLogin = false

    private var onLoginSuccess: ((String) -> Void)?

    init(router: Router<AppRoute>? = nil, phoneNumber: String, dialCode: String = "",
         verificationId: String, onLoginSuccess: ((String) -> Void)? = nil) {
        self.router = router
        self.phoneNumber = phoneNumber
        self.dialCode = dialCode
        self.verificationId = verificationId
        self.onLoginSuccess = onLoginSuccess
        self.preference = appResolve(serviceType: AppPreference.self)
        
        super.init()
        
        runTimer()
        isFromPhoneLogin = onLoginSuccess == nil
    }

    // MARK: - Data Loading
    func verifyOTP() {
        guard !otp.isEmpty else { return }

        let credential = FirebaseProvider.phoneAuthProvider.credential(withVerificationID: verificationId,
                                                                       verificationCode: otp)
        showLoader = true
        FirebaseProvider.auth.signIn(with: credential) {[weak self] (result, _) in
            self?.showLoader = false
            if let result {
                guard let self else { return }
                self.resendTimer?.invalidate()
                let user = User(id: result.user.uid, firstName: nil, lastName: nil, emailId: nil,
                                   phoneNumber: result.user.phoneNumber, loginType: .Phone)
                self.preference.user = user
                self.preference.isVerifiedUser = true
                self.onVerificationSuccess()
            } else {
                self?.onLoginError()
            }
        }
    }

    func resendOtp() {
        showLoader = true
        FirebaseProvider.phoneAuthProvider.verifyPhoneNumber((dialCode + phoneNumber), uiDelegate: nil) { [weak self] (verificationID, error) in
            guard let self else { return }
            self.showLoader = false
            if error != nil {
                if (error! as NSError).code == FirebaseAuth.AuthErrorCode.webContextCancelled.rawValue {
                    self.showAlertFor(message: "Something went wrong! Please try after some time.")
                } else if (error! as NSError).code == FirebaseAuth.AuthErrorCode.tooManyRequests.rawValue {
                    self.showAlertFor(title: "Warning !!!", message: "Too many attempts, please try after some time.")
                } else if (error! as NSError).code == FirebaseAuth.AuthErrorCode.missingPhoneNumber.rawValue || (error! as NSError).code == FirebaseAuth.AuthErrorCode.invalidPhoneNumber.rawValue {
                    self.showAlertFor(message: "Enter a valid phone number")
                } else {
                    print("VerifyOtpViewModel: \(#function) Phone login fail with error: \(error.debugDescription)")
                    self.showAlertFor(title: "Authentication failed",
                                      message: "Apologies, we were not able to complete the authentication process. Please try again later.")
                }
            } else {
                self.verificationId = verificationID ?? ""
                self.runTimer()
            }
        }
    }

    // MARK: - User Actions
    func handleBackBtnTap() {
        router?.pop()
    }

    func editButtonAction() {
        router?.pop()
    }
}

// MARK: - Helper Methods
extension VerifyOtpViewModel {
    private func runTimer() {
        resendOtpCount = 30
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    @objc func update() {
        if resendOtpCount > 0 {
            resendOtpCount -= 1
        } else {
            resendTimer?.invalidate()
        }
    }

    private func onLoginError() {
        showAlertFor(title: "Invalid OTP", message: "Please, enter a valid OTP code.")
    }

    private func onVerificationSuccess() {
        if onLoginSuccess == nil {
            router?.popToRoot()
        } else {
            onLoginSuccess?(otp)
        }
    }
}
