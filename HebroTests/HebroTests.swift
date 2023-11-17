//
//  HebroTests.swift
//  HebroTests
//
//  Created by Hodaya Rosenberg on 7/24/23.
//



import XCTest
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

@testable import Hebro

final class HebroTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError() // Correctly using 'try' here
        FirebaseApp.configure()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error)")
        }
    }



    func testCreateUserSuccess() async throws {
        let email = "test@email.com"
        let password = "password"

        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            XCTAssertNotNil(result.user)
            XCTAssertEqual(result.user.email, email) // Additional check for email
        } catch {
            XCTFail("Failed to create user: \(error)")
        }
    }

    func testLoginUserSuccess() async throws {
        let email = "test@example.com"
        let password = "password"

        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            XCTAssertNotNil(result.user)
            XCTAssertEqual(result.user.email, email) // Additional check for email
        } catch {
            XCTFail("Failed to login user: \(error)")
        }
    }

    func testPerformanceExample() throws {
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
