//
//  String+Extension.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 02/12/24.
//

extension String {
    public func getNumbersOnly() -> String {
        self.filter("0123456789".contains)
    }
}
