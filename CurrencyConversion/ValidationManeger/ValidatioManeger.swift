//
//  ValidatioManeger.swift
//  CurrencyConversion
//
//  Created by esterelzek on 28/08/2023.
//

import Foundation

//MARK: -ValidationManager
class ValidationManager {
    static let shared = ValidationManager()
    private init () {}
    func validateTextFieldInput(_ input: String) -> Bool {
        if input.isEmpty {
            return false
        }
        if let number = Int(input) {
            return number > 0
        }
        return Double(input) != nil
    }
}
