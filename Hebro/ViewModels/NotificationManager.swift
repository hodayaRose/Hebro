//
//  DataSource.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/10/23.
//

import Foundation
import SwiftUI


///UpdateModel 
class NotificationManager: ObservableObject {
    @Published var data: [String] = [] // Example property
     func addUpdate(){
        updates.append(Update(image: K.Images.Card1, title: "new Update", text: "new Update detail", date:"Aug 11"))
    }
    func removeUpdate(firstIndex : Int){
        updates.remove(at: firstIndex)
    }
    @Published var updates: [Update] = [
        Update(image: K.Images.house, title: "בית", text: " A House. \n יש לו בית גדול עם שדות תות", date: "JAN 1"),
        Update(image:K.Images.hello, title: "שלום", text: "Hello. \n שלום משה מה שלומך", date: "OCT 17"),
        Update(image:K.Images.dog , title: "כלב", text: "A Dog. \n הכלב ישן במלונה", date: "AUG 27"),
        Update(image:K.Images.glasses , title: "משקפיים", text: "Glasses \n חני קנתה משקפיים חדשים ", date: "JUNE 26"),
        Update(image:K.Images.airplane, title: " מטוס" ,text: "An Airplane. \n המטוס טס לעננים  ", date: "JUN 11")
    ]
}
