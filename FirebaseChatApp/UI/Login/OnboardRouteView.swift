//
//  OnboardRouteView.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

import SwiftUI

struct OnboardRouteView: View {
    
    @State var router = Router(root: AppRoute.LoginView)
    
    var body: some View {
        RouterView(router: router) { route in
            switch route {
            case .LoginView:
                LoginView(viewModel: LoginViewModel(router: router))
            case .PhoneLoginView:
                PhoneLoginView(viewModel: PhoneLoginViewModel(router: router))
            case .OTPView(let phoneNumber, let dialCode, let verificationId):
                VerifyOtpView(viewModel: VerifyOtpViewModel(router: router, phoneNumber: phoneNumber, dialCode: dialCode, verificationId: verificationId))
            default:
                EmptyRouteView(routeName: self)
            }
        }
    }
}

#Preview {
    OnboardRouteView()
}
