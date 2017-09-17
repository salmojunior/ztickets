//
//  Ticket.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import Foundation

struct Ticket {
    // MARK: - Constants
    
    private let kIdKey = "id"
    private let kSubjectKey = "subject"
    private let kDescriptionKey = "description"
    private let kStatusKey = "status"
    
    // MARK: - Properties
    
    let id: Int
    let subject: String
    let description: String
    let status: Status?
    
    // MARK: - Initializer
    
    init(dictionary: [String: Any]) throws {
        guard let id = dictionary[kIdKey] as? Int else {
            throw BusinessError.invalidDictionaryKey(kIdKey)
        }
        guard let subject = dictionary[kSubjectKey] as? String else {
            throw BusinessError.invalidDictionaryKey(kSubjectKey)
        }
        guard let description = dictionary[kDescriptionKey] as? String else {
            throw BusinessError.invalidDictionaryKey(kDescriptionKey)
        }
        guard let status = dictionary[kStatusKey] as? String else {
            throw BusinessError.invalidDictionaryKey(kStatusKey)
        }
        
        self.id = id
        self.subject = subject
        self.description = description
        self.status = Status(rawValue: status)
    }
}
