//
//  JSONUtils.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 02/12/24.
//

import Foundation

public struct JSONUtils {
    public static func readJSONFromFile<T: Decodable>(fileName: String, type: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("JSONUtils: \(#function) error - \(error).")
            }
        }
        return nil
    }
}
