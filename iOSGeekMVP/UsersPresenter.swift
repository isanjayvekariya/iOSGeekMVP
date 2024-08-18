//
//  UsersPresenter.swift
//  iOSGeekMVP
//
//  Created by Sanjay Vekariya on 8/11/24.
//

import Foundation

protocol UsersPresenting {
    var controller: UsersViewControlling? { get set }
    func loadUsers()
}

final class UsersPresenter: UsersPresenting {
    weak var controller: UsersViewControlling?
    private let serviceProvider: UsersServiceProviding
    
    init(serviceProvider: UsersServiceProviding) {
        self.serviceProvider = serviceProvider
    }
    
    func loadUsers() {
        serviceProvider.fetchUsers { [weak self] users in
            guard let self = self else { return }
            if let users = users {
                DispatchQueue.main.async {
                    self.controller?.showUsers(users)
                }
            } else {
                DispatchQueue.main.async {
                    self.controller?.showError("Failed to load users")
                }
            }
        }
    }
}
