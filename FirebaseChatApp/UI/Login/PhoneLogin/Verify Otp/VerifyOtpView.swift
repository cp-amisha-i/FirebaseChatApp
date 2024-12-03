//
//  VerifyOtpView.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 02/12/24.
//

import SwiftUI

public struct VerifyOtpView: View {
    
    @State var viewModel: VerifyOtpViewModel
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("Verification code")
                .font(.title.bold())
            
            TextField("Verification Code", text: $viewModel.otp)
                .padding(.horizontal)
                .keyboardType(.numberPad)
                .frame(height: 56)
                .background(RoundedRectangle(cornerRadius: 16).strokeBorder(.disableText.opacity(0.4), lineWidth: 1))
            
            PrimaryButton(text: "Verify Code") {
                viewModel.verifyOTP()
            }
            
            if viewModel.resendOtpCount > 0 {
                Group {
                    Text("Resend code ")
                        .foregroundColor(.secondaryText)
                    + Text("00:\(String(format: "%02d", viewModel.resendOtpCount))")
                        .foregroundColor(.primaryText)
                }
            } else {
                VStack(spacing: 0) {
                    Button("Resend Code ?") {
                        viewModel.resendOtp()
                    }
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .padding(.top, -10)
                    
                    Divider()
                        .frame(height: 1)
                        .background(.appPrimary)
                }
                .fixedSize(horizontal: true, vertical: false)
            }
        }
        .padding(.top, -50)
        .padding(.horizontal, 16)
        .alertView.alert(isPresented: $viewModel.showAlert, alertStruct: viewModel.alert)
    }
}
