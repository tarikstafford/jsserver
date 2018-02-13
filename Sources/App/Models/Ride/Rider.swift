//
//  Rider.swift
//  MongoTestPackageDescription
//
//  Created by Tarik Stafford on 4/2/18.
//

import Foundation
import MongoKitten

struct Rider{
    
    let userID: String
    var riderDidArrive: Bool
    
    init(userID: String, riderDidArrive: Bool = false) {
        
        self.userID = userID
        self.riderDidArrive = riderDidArrive
    }
    
    func createNewObject() -> Any {
        return [
            "userID": userID,
            "riderDidArrive" : riderDidArrive
        ]
    }
}
