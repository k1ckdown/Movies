//
//  ValidateUsenameUseCase.swift
//  Movies
//
//  Created by Ivan Semenov on 26.10.2023.
//

import Foundation

final class ValidateUsenameUseCase {

    enum UsernameValidationError: LocalizedError {
        case invalidUsername

        var errorDescription: String? {
            "Invalid, can only contain letters or digits"
        }
    }

    private enum Constants {
        static let formatString = "SELF MATCHES %@"
        static let regex = "[a-zA-Z0-9]+"
    }

    func execute(_ username: String) throws {
        let usernamePredicate = NSPredicate(
            format: Constants.formatString,
            Constants.regex
        )
        
        guard usernamePredicate.evaluate(with: username) else {
            throw UsernameValidationError.invalidUsername
        }
    }
}