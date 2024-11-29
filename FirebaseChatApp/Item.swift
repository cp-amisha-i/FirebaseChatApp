//
//  Item.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
