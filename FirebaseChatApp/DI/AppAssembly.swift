//
//  AppAssembly.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

import Swinject

public class AppAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {

        container.register(AppPreference.self) { _ in
            AppPreference.init()
        }.inObjectScope(.container)
    }
}
