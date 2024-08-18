//
//  UsersServiceProvider.swift
//  iOSGeekMVP
//
//  Created by Sanjay Vekariya on 8/11/24.
//

import Foundation

protocol UsersServiceProviding {
    func fetchUsers(completion: @escaping ([User]?) -> Void)
}

struct ServiceConstants {
    static let usersAPIUrl = "https://jsonplaceholder.typicode.com/users"
}

struct UsersServiceProvider: UsersServiceProviding {
    func fetchUsers(completion: @escaping ([User]?) -> Void) {
        guard let url = URL(string: ServiceConstants.usersAPIUrl) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let users = try? JSONDecoder().decode([User].self, from: data)
            completion(users)
        }
        task.resume()
    }
}
