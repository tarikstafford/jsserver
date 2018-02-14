//
//  RideController.swift
//  jumpseat-testPackageDescription
//
//  Created by Tarik Stafford on 13/2/18.
//

import Foundation
import Vapor

internal struct RideController {
    
    private var drop: Droplet
    
    internal init(drop: Droplet) {
        self.drop = drop
    }
    
    internal func addRoutes(){
        
        let group = drop.grouped("api", "rides")
        group.post("create" ,handler: create)
    }
    
    private func create(_ req: Request) throws -> ResponseRepresentable {
        
        guard let json = req.json else { throw Abort.badRequest }
        
        let ride = try Ride.init(json: json)
        try ride.save()
        
        return try ride.makeJSON()
    }
    
}
