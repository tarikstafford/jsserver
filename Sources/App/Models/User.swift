//
//  User.swift
//  Sexy-Server2PackageDescription
//
//  Created by Tarik Stafford on 31/1/18.
//

import Vapor
import FluentProvider
import Validation

final class User: Model {
    
    let storage = Storage()
    
    var username: String
    var password: String
    var email: String
    var name: String
    
    struct Keys {
        static let id = "id"
        static let username = "username"
        static let password = "password"
        static let email = "email"
        static let name = "name"
    }
    
    init(row: Row) throws {
        self.username = try row.get(Keys.username)
        self.password = try row.get(Keys.password)
        self.email = try row.get(Keys.email)
        self.name = try row.get(Keys.name)
    }
    
    init(json: JSON) throws {
        
        
        let passwordValidator = FieldLengthValidator.init(min: 8, max: 30)
        let nameValidator = NameValidator()
        
        guard let username:   String = try json.get(Keys.username), nameValidator.isValid(username) else { throw Abort.invalid("username") }
        guard let password:   String = try json.get(Keys.password),passwordValidator.isValid(password) else { throw Abort.invalid("password") }
        guard let email:   String = try json.get(Keys.email), EmailValidator().isValid(email) else { throw Abort.invalid("email") }
        guard let name:   String = try json.get(Keys.name), nameValidator.isValid(name) else { throw Abort.invalid("name") }
        
        self.username = username
        self.password = password
        self.email = email
        self.name = name
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Keys.username, self.username)
        try row.set(Keys.password, self.password)
        try row.set(Keys.email, self.email)
        try row.set(Keys.name, self.name)
        return row
    }
}

extension User: JSONRepresentable {
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        
        try json.set(Keys.id, id?.wrapped)
        try json.set(Keys.username, username)
        try json.set(Keys.email, email)
        try json.set(Keys.name, name)
        
        return json
    }
    
}

extension User: Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.string(Keys.username)
            builder.string(Keys.password)
            builder.string(Keys.email)
            builder.string(Keys.name)
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
    
}

