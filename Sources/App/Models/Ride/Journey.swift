//
//  Journey.swift
//  MongoTestPackageDescription
//
//  Created by Tarik Stafford on 4/2/18.
//

class Journey {
    
    let pickUpLoc: LocationData
    let dropOffLoc: LocationData
    let tripDuration: String
    let tripDistance: String
    let durationValue: Int
    let distanceValue: Int
    let route: String
    
    init(pickUp: LocationData, dropOff: LocationData, tripDuration: String, durationValue: Int, distanceValue: Int, tripDistance: String, route: String) {
        
        self.pickUpLoc = pickUp
        self.dropOffLoc = dropOff
        self.tripDistance = tripDistance
        self.tripDuration = tripDuration
        self.distanceValue = distanceValue
        self.durationValue = durationValue
        self.route = route
    }
}

