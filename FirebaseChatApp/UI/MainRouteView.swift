//
//  MainRouteView.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

import SwiftUI
import SwiftData

struct MainRouteView: View {
    
    @State var router = Router(root: AppRoute.LoginView)
    
    let preference: AppPreference
    
    init() {
        self.preference = appResolve(serviceType: AppPreference.self)
    }
   
    var body: some View {
        VStack {
            if preference.isVerifiedUser {
                HomeRouteView()
            } else {
                OnboardRouteView()
            }
        }
    }
}
