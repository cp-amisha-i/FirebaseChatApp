//
//  LoginView.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            LoginOptionsView(showGoogleLoading: viewModel.showGoogleLoading, showAppleLoading: viewModel.showAppleLoading,
                             onGoogleLoginClick: viewModel.onGoogleLoginClick, onAppleLoginClick: viewModel.onAppleLoginClick,
                             onPhoneLoginClick: viewModel.onPhoneLoginClick)
        }
        .background(.surface)
        .alertView.alert(isPresented: $viewModel.showAlert, alertStruct: viewModel.alert)
    }
}

private struct LoginOptionsView: View {

    let showGoogleLoading: Bool
    let showAppleLoading: Bool

    let onGoogleLoginClick: () -> Void
    let onAppleLoginClick: () -> Void
    let onPhoneLoginClick: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            LoginOptionsButtonView(image: .googleIcon, buttonName: "Sign in with Google", showLoader: showGoogleLoading,
                                   onClick: onGoogleLoginClick)
            LoginOptionsButtonView(systemImage: ("apple.logo", .primaryText, (14, 16)), buttonName: "Sign in with Apple",
                                   showLoader: showAppleLoading, onClick: onAppleLoginClick)
            LoginOptionsButtonView(systemImage: ("phone.fill", .white, (12, 12)),
                                   buttonName: "Sign in with Phone Number", bgColor: .appPrimary,
                                   buttonTextColor: .white, showLoader: false, onClick: onPhoneLoginClick)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

private struct LoginOptionsButtonView: View {

    let image: ImageResource?
    let systemImage: (name: String, color: Color, size: (width: CGFloat, height: CGFloat))?
    let buttonName: String
    var bgColor: Color
    var buttonTextColor: Color
    let showLoader: Bool
    let onClick: () -> Void

    init(image: ImageResource? = nil,
         systemImage: (name: String, color: Color, size: (width: CGFloat, height: CGFloat))? = nil,
         buttonName: String, bgColor: Color = .container, buttonTextColor: Color = .primaryDark,
         showLoader: Bool, onClick: @escaping () -> Void) {
        self.image = image
        self.systemImage = systemImage
        self.buttonName = buttonName
        self.bgColor = bgColor
        self.buttonTextColor = buttonTextColor
        self.showLoader = showLoader
        self.onClick = onClick
    }

    public var body: some View {
        Button {
            onClick()
        } label: {
            HStack(alignment: .center, spacing: 12) {
                if showLoader {
                    ImageLoaderView(tintColor: .appPrimary)
                }

                if let image {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                } else if let systemImage {
                    Image(systemName: systemImage.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: systemImage.size.width, height: systemImage.size.height)
                        .foregroundStyle(systemImage.color)
                }

                Text(buttonName)
                    .lineLimit(1)
                    .foregroundStyle(buttonTextColor)
                    .frame(height: 50)
                    .minimumScaleFactor(0.5)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(bgColor)
            .clipShape(Capsule())
        }
        .buttonStyle(.scale)
    }
}
