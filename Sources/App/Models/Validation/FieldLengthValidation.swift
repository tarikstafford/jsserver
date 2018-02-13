//
//  FieldLengthValidation.swift
//  Sexy-Server2PackageDescription
//
//  Created by Tarik Stafford on 1/2/18.
//

import Foundation
import Validation

class FieldLengthValidator: Validatable {
    
    private let minimumLength: Int
    private let maximumLength: Int
    
    init(min: Int = 3, max: Int = 30) {
        minimumLength = min
        maximumLength = max
    }
    
    func isValid(_ value: String) -> Bool {
        do {
            try value.validated(by: Count.min(minimumLength) && Count.max(maximumLength))
            return true
        } catch {
            return false
        }
    }
}
