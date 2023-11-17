//
//  Section.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/1/23.
//

import Foundation
import SwiftUI

struct SectionModel: Identifiable{
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image : Image
    var color : Color
}

let sectionData = [
    SectionModel(title: "Bring Hebrew Home ", text: "AR Game ", logo: K.Images.logoCircle, image: Image(K.Images.Card1), color: Color("card1")),
    SectionModel(title: "Color Your Words", text: "Coloring Book", logo: K.Images.logoCircle, image: Image("Card3"), color:Color("card3") ),
    SectionModel(title: "Its Story Time!", text: "story telling in hebrew", logo: K.Images.logoCircle, image: Image("Card1"), color: Color("card2"))
]



