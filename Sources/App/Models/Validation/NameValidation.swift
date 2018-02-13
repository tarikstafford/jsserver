//
//  NameValidation.swift
//  Sexy-Server2PackageDescription
//
//  Created by Tarik Stafford on 1/2/18.
//

import Foundation
import Validation

internal final class NameValidator: FieldLengthValidator {
    
    private let validCharacters = "abcdefghijklmnopqrstuvwxyz01234567890_@."
    
    internal override func isValid(_ value: String) -> Bool {
        guard super.isValid(value) else { return false }
        
        var charactersAreValid = true
        
        value.lowercased().forEach { [weak self] in
            guard
                let strongSelf = self,
                !strongSelf.validCharacters.contains($0)
                else { return }
            
            charactersAreValid = false
        }
        
        return charactersAreValid
    }
}
