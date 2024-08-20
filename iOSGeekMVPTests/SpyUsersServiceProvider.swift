//
//  SpyUsersServiceProvider.swift
//  iOSGeekMVPTests
//
//  Created by Sanjay Vekariya on 8/12/24.
//

import Foundation
import XCTest
@testable import iOSGeekMVP

final class SpyUsersServiceProvider: UsersServiceProviding {
    var success = true
    var expectation: XCTestExpectation?
    
    func fetchUsers(completion: @escaping ([iOSGeekMVP.User]?) -> Void) {
        if success {
            guard let users = loadJson(filename: "users") else {
                lookForExpectation("fetchUsersFailure")
                return completion(nil)
            }
            lookForExpectation("fetchUsersSuccess")
            completion(users)
        } else {
            lookForExpectation("fetchUsersFailure")
            completion(nil)
        }
    }
    
    private func lookForExpectation(_ desc: String) {
        if expectation?.description == desc {
            expectation?.fulfill()
            expectation = nil
        }
    }
}

func loadJson(filename fileName: String) -> [iOSGeekMVP.User]? {
    let jsonName = fileName.replacingOccurrences(of: ".json", with: "")
    guard let url = Bundle(for: SpyUsersServiceProvider.self).url(forResource: jsonName, withExtension: "json"),
          let data = try? Data(contentsOf: url, options: [])
    else {
        return nil
    }
    do {
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode([iOSGeekMVP.User].self, from: data)
        return jsonData
    } catch {
        print("error:\(error.localizedDescription)")
        return nil
    }
}

extension XCTest {
    
}
