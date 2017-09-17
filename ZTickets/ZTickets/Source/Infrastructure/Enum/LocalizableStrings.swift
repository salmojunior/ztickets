//
//  LocalizableStrings.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import Foundation

enum LocalizableStrings: String {
    // MARK: - Keys
    
    case ticketsTitle

    // MARK: - Public Functions
    
    /**
     This method localizes the raw value of the object
     
     - returns: Return the localized string for that key
     */
    func localize() -> String {
        return self.rawValue.localized
    }
}

// MARK: - String Extension

private extension String {
    
    /// Get localized string without comment
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
