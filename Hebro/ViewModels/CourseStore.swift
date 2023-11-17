//
//  CourseStore.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/25/23.
//

import SwiftUI
import Contentful


let client = Client(spaceId: K.contentful.spaceId , accessToken: K.contentful.accessToken )

func getArray(id: String, completion: @escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)
    
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                print(array.items)
                completion(array.items)
            }
        case .failure(let error):
            print(error)
        }
    }
}
//data returned from contentful API
class CourseStore: ObservableObject{
    
    @Published  var courses: [Course] = []
    var index = 0
    
    
    
    init() {
        //an asset colors Data Array
        let colors = [UIColor(named: "card1"),UIColor(named: "card2"),UIColor(named: "card3"),UIColor(named: "card4"),UIColor(named: "card5"),UIColor(named: "accenti")]
        var currentIndex = 0
        
        getArray(id: "course") { [self] (items) in
            
            items.forEach { (item) in
                self.courses.append(
                    Course(
                        title: item.fields["title"] as! String,
                        subtitle: item.fields["subtitle"] as! String,
                        image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                        logo: UIImage(named: "logocircleB")!,
                        //generating randon card background color
                        color: colors[currentIndex % colors.count]! ,
                        
                        show: item.fields["show"] as! Bool,
                        
                        headline: item.fields["headline"] as! String,
                        content: item.fields["content"] as! String
                    ))
                //i++ for Color to get next color in colors[]
                currentIndex = (currentIndex + 1) % colors.count
                
            }
        }
    }
}


