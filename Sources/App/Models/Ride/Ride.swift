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
    
    // Host User
    let hostUID: String
    
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
        static let id = "_id"
        static let seatsAvailable = "seatsAvailable"
        static let priceString = "priceString"
        static let priceCurrency = "priceCurrency"
        static let ridePostTimeStamp = "ridePostTimeStamp"
        static let rideDepartureTimeStamp = "rideDepartureTimeStamp"
        static let pickUpPointName = "pickUpPointName"
        static let pickUpPointLongitude = "pickUpPointLongitude"
        static let pickUpPointLatitude = "pickUpPointLatitude"
        static let destinationName = "destinationPointName"
        static let destinationPointLongitude = "destinationPointLongitude"
        static let destinationPointLatitude = "destinationPointLatitude"
        static let hostUID = "hostUID"
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
        static let riders = "riders"
        static let distanceValue = "tripDistanceValue"
        static let durationValue = "tripDurationValue"
        
        
    }
    
    init(row: Row) throws {
        
        self.seatsAvailable = row.get(Keys.seatsAvailable)
        self.priceString = row.get(Keys.priceString)
        self.priceCurrency = row.get(Keys.priceCurrency)
        self.ridePostTimeStamp = row.get(Keys.ridePostTimeStamp)
        self.rideDepartureTimeStamp = row.get(Keys.rideDepartureTimeStamp)
        self.hostUID = row.get(Keys.hostUID)
        self.rideState = row.get(Keys.rideState)
        self.surfboard = row.get(Keys.surfboard)
        self.gender = row.get(Keys.gender)
        self.smoking = row.get(Keys.smoking)
        self.aircon = row.get(Keys.aircon)
        self.pets = row.get(Keys.pets)
        self.baggage = row.get(Keys.baggage)
        self.disabled = row.get(Keys.disabled)

    }
    
    // MARK: Documents
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Keys.seatsAvailable, seatsAvailable)
        try row.set(Keys.priceString, priceString)
        try row.set(Keys.priceCurrency, priceCurrency)
        try row.set(Keys.ridePostTimeStamp, ridePostTimeStamp)
        try row.set(Keys.rideDepartureTimeStamp, rideDepartureTimeStamp)
        try row.set(Keys.pickUpPointName, pickUpName)
        try row.set(Keys.pickUpPointLongitude, pickUpLong)
        try row.set(Keys.pickUpPointLatitude, pickUpLat)
        try row.set(Keys.destinationName, destinationName)
        try row.set(Keys.destinationPointLongitude, destinationLong)
        try row.set(Keys.destinationPointLatitude, destinationLat)
        try row.set(Keys.hostUID, hostUID)
        try row.set(Keys.rideState, rideState)
        try row.set(Keys.surfboard, surfboard)
        try row.set(Keys.gender, gender)
        try row.set(Keys.pets, pets)
        try row.set(Keys.aircon, aircon)
        try row.set(Keys.smoking, smoking)
        try row.set(Keys.baggage, baggageAllowance)
        try row.set(Keys.disabled, disabledAccess)
        try row.set(Keys.duration, tripDuration)
        try row.set(Keys.distance, tripDistance)
        try row.set(Keys.route, route)
        try row.set(Keys.distanceValue, distanceValue)
        try row.set(Keys.durationValue, durationValue)
    }
    
    
    
    // MARK: Init -- Create Object for DB
    init(seatsAvailable: Int, priceString: String, priceCurrency: String, ridePostTimeStamp: Int,rideDepartureTimeStamp: Int, hostUID: String, rideState: String = "preRide", surfBoard: Bool, gender: String, smoking: Bool, aircon: Bool, pets: Bool, baggageAllowance: String, disabledAccess: Bool, journey: Journey ) {
        
        self.seatsAvailable = seatsAvailable
        self.priceString = priceString
        self.priceCurrency = priceCurrency
        self.ridePostTimeStamp = ridePostTimeStamp
        self.rideDepartureTimeStamp = rideDepartureTimeStamp
        self.hostUID = hostUID
        self.id = ObjectId()
        self.riderArray = []
        self.rideState = rideState
        self.surfBoard = surfBoard
        self.gender = gender
        self.smoking = smoking
        self.aircon = aircon
        self.pets = pets
        self.baggageAllowance = baggageAllowance
        self.disabledAccess = disabledAccess
        self.journey = journey
        
    }
    
    func save() throws {
        let query: Query = Keys.id == self.id
        
        try Ride.collection.update(query, to: documentForSave, upserting: true)
    }
}
