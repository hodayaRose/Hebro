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
    SectionModel(title: K.Sections.title1, text: K.Sections.text1, logo: K.Images.logoCircle, image: Image(K.Images.Card1), color: Color("card1")),
    SectionModel(title: K.Sections.title2, text: K.Sections.text2, logo: K.Images.logoCircle, image: Image(K.Images.Card3), color:Color("card3") ),
    SectionModel(title: K.Sections.title3, text: K.Sections.text3, logo: K.Images.logoCircle, image: Image(K.Images.Card1), color: Color("card2"))
]



