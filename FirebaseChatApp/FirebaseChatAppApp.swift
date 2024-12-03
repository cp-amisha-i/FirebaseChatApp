//
//  FirebaseChatAppApp.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

import SwiftUI
import SwiftData

@main
struct FirebaseChatAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        Injector.shared.initInjector()
    }

    var body: some Scene {
        WindowGroup {
            MainRouteView()
        }
    }
}
