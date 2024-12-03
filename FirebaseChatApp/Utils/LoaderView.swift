//
//  LoaderView.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

import SwiftUI

struct ImageLoaderView: View {

    @StateObject var viewModel: LoaderViewModel = .init()

    private let tintColor: Color
    private let scaleEffect: Double

    init(tintColor: Color = .secondaryText, scaleEffect: Double = 1) {
        self.tintColor = tintColor
        self.scaleEffect = scaleEffect
    }

    var body: some View {
        ZStack {
            if viewModel.isStillLoading {
                ProgressView()
                    .scaleEffect(scaleEffect, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
            }
        }
        .onAppear(perform: viewModel.onViewAppear)
    }
}
