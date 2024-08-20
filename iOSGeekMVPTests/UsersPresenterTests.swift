//
//  UsersPresenterTests.swift
//  iOSGeekMVPTests
//
//  Created by Sanjay Vekariya on 8/12/24.
//

import XCTest
@testable import iOSGeekMVP

final class UsersPresenterTests: XCTestCase {
    let spyServiceProvider = SpyUsersServiceProvider()
    let mockController = MockUserViewController()
    private lazy var sut = makeSUT()
    
    func test_loadUsers_succss() {
        let serviceExp = expectation(description: "fetchUsersSuccess")
        spyServiceProvider.expectation = serviceExp
        let uiExp = expectation(description: "showUsers")
        mockController.expectation = uiExp
        
        sut.loadUsers()
        
        wait(for: [serviceExp, uiExp], timeout: 1)
    }
    
    func test_loadUsers_failure() {
        let serviceExp = expectation(description: "fetchUsersFailure")
        spyServiceProvider.success = false
        spyServiceProvider.expectation = serviceExp
        let uiExp = expectation(description: "showError")
        mockController.expectation = uiExp
        
        sut.loadUsers()
        
        wait(for: [serviceExp, uiExp], timeout: 1)
    }
    
    private func makeSUT() -> UsersPresenter {
        let sut = UsersPresenter(serviceProvider: spyServiceProvider)
        sut.controller = mockController
        return sut
    }
}

final class MockUserViewController: UsersViewControlling {
    var expectation: XCTestExpectation?

    func showUsers(_ users: [iOSGeekMVP.User]) {
        lookForExpectation("showUsers")
    }
    
    func showError(_ message: String) {
        lookForExpectation("showError")
    }
    
    private func lookForExpectation(_ desc: String) {
        if expectation?.description == desc {
            expectation?.fulfill()
            expectation = nil
        }
    }

}
