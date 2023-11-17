//
//  Product.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/9/23.
//

import Foundation
import SwiftUI

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    let price: Float = 9.99
    @ObservedObject private var store = CourseStore()
}

