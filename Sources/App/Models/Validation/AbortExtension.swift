//
//  AbortExtension.swift
//  Sexy-Server2PackageDescription
//
//  Created by Tarik Stafford on 1/2/18.
//

import HTTP

extension Abort {
    
    static func invalid(_ invalidField: String) -> Abort {
        let reason = "Invalid \(invalidField)."
        return Abort(.badRequest, reason: reason)
    }
}
