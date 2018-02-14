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
        group.get(handler: allRides)
        group.get(Ride.parameter, "passengers", handler: getPassengers)
        group.post("create" ,handler: create)
        group.post(Ride.parameter, "addRider",User.parameter, handler: addRider)
    }
    
    private func create(_ req: Request) throws -> ResponseRepresentable {
        
        guard let json = req.json else { throw Abort.badRequest }
        
        let ride = try Ride.init(json: json)
        try ride.save()
        return try ride.makeJSON()
    }
    
    private func allRides(_ req: Request) throws -> ResponseRepresentable {
        
        let rides = try Ride.all()
        return try rides.makeJSON()
    }
    
    private func addRider(_ req: Request) throws -> ResponseRepresentable {
        
        let user = try req.parameters.next(User.self)
        let ride = try req.parameters.next(Ride.self)
        
        if ride.seatsAvailable > 0 {
            if ride.hostId == user.id {
                throw Abort.invalid("holder for HOST cannot be PASSENGER")
            } else if (try ride.passengers.find(user.id) != nil) {
                throw Abort.invalid("holder for USER IS ALREADY PASSENGER")
            } else {
                try ride.passengers.add(user)
                ride.seatsAvailable = ride.seatsAvailable - 1
                try ride.save()
                return ("\(user.name) has succesfully joined the ride to \(ride.destinationName)")
            }
        } else {
            throw Abort.invalid("No Seats Available")
        }
    }
    
    private func getPassengers(_ req: Request) throws -> ResponseRepresentable {
        
        let ride = try req.parameters.next(Ride.self)
        return try ride.passengers.all().makeJSON()
    }
    
}
