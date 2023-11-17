//
//  AlertManager.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/16/23.
//

import Foundation
//a class that handles the state and the alert message in project
class AlertManager: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
}
