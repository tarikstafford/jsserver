//
//  Ride.swift
//  MongoTestPackageDescription
//
//  Created by Tarik Stafford on 4/2/18.
//

import Vapor
import FluentProvider
import MapKit

final class Ride: Model {
    
    let storage = Storage()
    
    // Ride Main Info
    let hostId: Identifier?
    var seatsAvailable: Int
    var rideState: String
    
    // Money Object
    let priceString: String
    let priceCurrency: String
    
    // Date Object
    let ridePostTimeStamp: Int
    let rideDepartureTimeStamp: Int
    
    // Journey
    let pickUpName: String
    let pickUpLat: Double
    let pickUpLong: Double
    let destinationName: String
    let destinationLat: Double
    let destinationLong: Double
    let tripDuration: String
    let tripDistance: String
    let durationValue: Int
    let distanceValue: Int
    let route: String
    
    // Options
    let baggage: String
    let surfboard: Bool
    let gender: String
    let smoking: Bool
    let aircon: Bool
    let pets: Bool
    let disabled: Bool
    
    // MARK: Keys
    struct Keys {
        static let id = "id"
        static let hostId = "hostId"
        static let seatsAvailable = "seatsAvailable"
        static let priceString = "priceString"
        static let priceCurrency = "priceCurrency"
        static let ridePostTimeStamp = "ridePostTimeStamp"
        static let rideDepartureTimeStamp = "rideDepartureTimeStamp"
        static let pickUpName = "pickUpName"
        static let pickUpPointLongitude = "pickUpPointLongitude"
        static let pickUpPointLatitude = "pickUpPointLatitude"
        static let destinationName = "destinationName"
        static let destinationPointLongitude = "destinationPointLongitude"
        static let destinationPointLatitude = "destinationPointLatitude"
        static let rideState = "rideState"
        static let surfboard = "surfboard"
        static let gender = "gender"
        static let pets = "pets"
        static let aircon = "aircon"
        static let smoking = "smoking"
        static let baggage = "baggage"
        static let disabled = "disabled"
        static let duration = "tripDuration"
        static let distance = "tripDistance"
        static let route = "tripRoute"
        static let distanceValue = "tripDistanceValue"
        static let durationValue = "tripDurationValue"
        
        
    }
    
    // MARK: Initializers
    init(json: JSON, user: User) throws {
        
        guard   let seatsAvailable: Int = try json.get(Keys.seatsAvailable),
                let priceString: String = try json.get(Keys.priceString),
                let priceCurrency: String = try json.get(Keys.priceCurrency),
                let ridePostTimeStamp: Int = try json.get(Keys.ridePostTimeStamp),
                let rideDepartureTimeStamp: Int = try json.get(Keys.rideDepartureTimeStamp),
                let pickUpName: String = try json.get(Keys.pickUpName),
                let pickUpPointLong: Double = try json.get(Keys.pickUpPointLongitude),
                let pickUpPointLat: Double = try json.get(Keys.pickUpPointLatitude),
                let destinationName: String = try json.get(Keys.destinationName),
                let destinationLong: Double = try json.get(Keys.destinationPointLongitude),
                let destinationLat: Double = try json.get(Keys.destinationPointLatitude),
                let rideState: String = try json.get(Keys.rideState),
                let surfboard: Bool = try json.get(Keys.surfboard),
                let gender: String = try json.get(Keys.gender),
                let pets: Bool = try json.get(Keys.pets),
                let aircon: Bool = try json.get(Keys.aircon),
                let smoking: Bool = try json.get(Keys.smoking),
                let baggage: String = try json.get(Keys.baggage),
                let disabled: Bool = try json.get(Keys.disabled),
                let duration: String = try json.get(Keys.duration),
                let distance: String = try json.get(Keys.distance),
                let route: String = try json.get(Keys.route),
                let distanceValue: Int = try json.get(Keys.distanceValue),
                let durationValue: Int = try json.get(Keys.durationValue)
            else { throw Abort.invalid("Invalid Field") }
        
        self.hostId = user.id
        self.seatsAvailable = seatsAvailable
        self.priceString = priceString
        self.priceCurrency = priceCurrency
        self.ridePostTimeStamp = ridePostTimeStamp
        self.rideDepartureTimeStamp = rideDepartureTimeStamp
        self.pickUpName = pickUpName
        self.pickUpLat = pickUpPointLat
        self.pickUpLong = pickUpPointLong
        self.destinationName = destinationName
        self.destinationLat = destinationLat
        self.destinationLong = destinationLong
        self.rideState = rideState
        self.surfboard = surfboard
        self.gender = gender
        self.pets = pets
        self.aircon = aircon
        self.smoking = smoking
        self.baggage = baggage
        self.disabled = disabled
        self.tripDuration = duration
        self.tripDistance = distance
        self.durationValue = durationValue
        self.distanceValue = distanceValue
        self.route = route
        
    }
    
    init(row: Row) throws {
        
        // Ride Main Info
        self.hostId = try row.get(Keys.hostId)
        self.seatsAvailable = try row.get(Keys.seatsAvailable)
        self.rideState = try row.get(Keys.rideState)
        
        // Money Object
        self.priceString = try row.get(Keys.priceString)
        self.priceCurrency = try row.get(Keys.priceCurrency)
        
        // Date Object
        self.ridePostTimeStamp = try row.get(Keys.ridePostTimeStamp)
        self.rideDepartureTimeStamp = try row.get(Keys.rideDepartureTimeStamp)
        
        // Journey
        self.pickUpName = try row.get(Keys.pickUpName)
        self.pickUpLong = try row.get(Keys.pickUpPointLongitude)
        self.pickUpLat = try row.get(Keys.pickUpPointLongitude)
        self.destinationName = try row.get(Keys.destinationName)
        self.destinationLong = try row.get(Keys.destinationPointLongitude)
        self.destinationLat = try row.get(Keys.destinationPointLatitude)
        self.durationValue = try row.get(Keys.durationValue)
        self.distanceValue = try row.get(Keys.distanceValue)
        self.tripDistance = try row.get(Keys.distance)
        self.tripDuration = try row.get(Keys.duration)
        self.route = try row.get(Keys.route)
        
        // Options
        self.surfboard = try row.get(Keys.surfboard)
        self.gender = try row.get(Keys.gender)
        self.smoking = try row.get(Keys.smoking)
        self.aircon = try row.get(Keys.aircon)
        self.pets = try row.get(Keys.pets)
        self.baggage = try row.get(Keys.baggage)
        self.disabled = try row.get(Keys.disabled)
    }
    
    // MARK: Row
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(User.foreignIdKey, hostId)
        try row.set(Keys.seatsAvailable, seatsAvailable)
        try row.set(Keys.priceString, priceString)
        try row.set(Keys.priceCurrency, priceCurrency)
        try row.set(Keys.ridePostTimeStamp, ridePostTimeStamp)
        try row.set(Keys.rideDepartureTimeStamp, rideDepartureTimeStamp)
        try row.set(Keys.pickUpName, pickUpName)
        try row.set(Keys.pickUpPointLongitude, pickUpLong)
        try row.set(Keys.pickUpPointLatitude, pickUpLat)
        try row.set(Keys.destinationName, destinationName)
        try row.set(Keys.destinationPointLongitude, destinationLong)
        try row.set(Keys.destinationPointLatitude, destinationLat)
        try row.set(Keys.rideState, rideState)
        try row.set(Keys.surfboard, surfboard)
        try row.set(Keys.gender, gender)
        try row.set(Keys.pets, pets)
        try row.set(Keys.aircon, aircon)
        try row.set(Keys.smoking, smoking)
        try row.set(Keys.baggage, baggage)
        try row.set(Keys.disabled, disabled)
        try row.set(Keys.duration, tripDuration)
        try row.set(Keys.distance, tripDistance)
        try row.set(Keys.route, route)
        try row.set(Keys.distanceValue, distanceValue)
        try row.set(Keys.durationValue, durationValue)
        
        return row
    }
}

extension Ride: JSONConvertible {
    
    convenience init(json: JSON) throws {
        let hostId: Identifier = try json.get(Keys.hostId)
        
        guard let user = try User.find(hostId) else { throw Abort.badRequest }
        
        try self.init(json: json, user: user)
    }
}

extension Ride: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        
        try json.set(Keys.id, id?.wrapped)
        try json.set(Keys.seatsAvailable, seatsAvailable)
        try json.set(Keys.priceString, priceString)
        try json.set(Keys.priceCurrency, priceCurrency)
        try json.set(Keys.ridePostTimeStamp, ridePostTimeStamp)
        try json.set(Keys.rideDepartureTimeStamp, rideDepartureTimeStamp)
        try json.set(Keys.pickUpName, pickUpName)
        try json.set(Keys.pickUpPointLongitude, pickUpLong)
        try json.set(Keys.pickUpPointLatitude, pickUpLat)
        try json.set(Keys.destinationName, destinationName)
        try json.set(Keys.destinationPointLongitude, destinationLong)
        try json.set(Keys.destinationPointLatitude, destinationLat)
        try json.set(Keys.rideState, rideState)
        try json.set(Keys.surfboard, surfboard)
        try json.set(Keys.gender, gender)
        try json.set(Keys.pets, pets)
        try json.set(Keys.aircon, aircon)
        try json.set(Keys.smoking, smoking)
        try json.set(Keys.baggage, baggage)
        try json.set(Keys.disabled, disabled)
        try json.set(Keys.duration, tripDuration)
        try json.set(Keys.distance, tripDistance)
        try json.set(Keys.route, route)
        try json.set(Keys.distanceValue, distanceValue)
        try json.set(Keys.durationValue, durationValue)
        try json.set(Keys.hostId, hostId)
        
        return json
    }
}

extension Ride: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.int(Keys.seatsAvailable)
            builder.string(Keys.rideState)
            builder.string(Keys.priceString)
            builder.string(Keys.priceCurrency)
            builder.int(Keys.ridePostTimeStamp)
            builder.int(Keys.rideDepartureTimeStamp)
            builder.string(Keys.pickUpName)
            builder.double(Keys.pickUpPointLongitude)
            builder.double(Keys.pickUpPointLatitude)
            builder.string(Keys.destinationName)
            builder.double(Keys.destinationPointLatitude)
            builder.double(Keys.destinationPointLongitude)
            builder.string(Keys.distance)
            builder.int(Keys.distanceValue)
            builder.string(Keys.duration)
            builder.int(Keys.durationValue)
            builder.string(Keys.gender)
            builder.string(Keys.baggage)
            builder.bool(Keys.aircon)
            builder.bool(Keys.disabled)
            builder.bool(Keys.pets)
            builder.bool(Keys.smoking)
            builder.bool(Keys.surfboard)
            builder.string(Keys.route)
            builder.parent(User.self)
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
    
}

extension Ride {
    var host: Parent<Ride, User>{
        return parent(id: hostId)
    }
}










