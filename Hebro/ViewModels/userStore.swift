//
//  userStore.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/1/23.
//

import SwiftUI


class UserStore: ObservableObject {
    @Published var isRegistered: Bool = UserDefaults.standard.bool(forKey: "isRegistered") {
        didSet {
            UserDefaults.standard.set(self.isRegistered, forKey: "isRegistered")
        }
    }
    @Published var showLogin = false
}
