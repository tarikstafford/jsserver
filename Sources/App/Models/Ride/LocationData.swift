//
//  LocationData.swift
//  JumpSeat
//
//  Created by Tarik Stafford on 9/14/17.
//  Copyright © 2017 Tarik Edison Stafford. All rights reserved.
//

import MapKit

/* Location Data contains geo info on a point, Location Data Set is a deprecated
 version of a Journey which contains a to and from location
 along with info about the trip including the route. */


public final class LocationData {
    let name: String
    let coordinates: CLLocationCoordinate2D
    
    
    init(name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.coordinates = coordinates
    }
    
    var locationObject: CLLocation {
        get {
            return CLLocation.init(latitude: coordinates.latitude, longitude: coordinates.longitude)
        }
    }
}



