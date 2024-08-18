//
//  MockUsersServiceProvider.swift
//  iOSGeekMVPTests
//
//  Created by Sanjay Vekariya on 8/12/24.
//

import Foundation
@testable import iOSGeekMVP

final class StubUsersServiceProvider: UsersServiceProviding {
    var success = true
    
    func fetchUsers(completion: @escaping ([iOSGeekMVP.User]?) -> Void) {
        if success {
            guard let users = loadJson(filename: "users") else {
                completion(nil)
                return
            }
            completion(users)
        } else {
            completion(nil)
        }
    }
}

func loadJson(filename fileName: String) -> [iOSGeekMVP.User]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([iOSGeekMVP.User].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
