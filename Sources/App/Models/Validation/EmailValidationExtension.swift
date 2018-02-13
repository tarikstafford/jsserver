//
//  EmailValidationExtension.swift
//  Sexy-Server2PackageDescription
//
//  Created by Tarik Stafford on 1/2/18.
//

import Validation

extension EmailValidator {
    
    func isValid(_ value: String) -> Bool {
        do {
            try EmailValidator().validate(value)
            return true
        } catch {
            return false
        }
    }
}
