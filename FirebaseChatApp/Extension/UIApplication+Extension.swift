//
//  UIApplication+Extension.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 02/12/24.
//

import UIKit

public extension UIApplication {
    /// to hide keyboard on outside tap
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
