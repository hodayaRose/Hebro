//
//  Course.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/1/23.
//

import Foundation
import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var title: String = ""
    var subtitle: String = ""
    var image : URL
    var logo: UIImage = UIImage(named: "logo")!
    var color: UIColor = UIColor(.black)
    var show: Bool = false
    var headline : String = "preview Headline"
    var content: String = "this is the preview content"
}
