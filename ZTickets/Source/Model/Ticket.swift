//
//  Ticket.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import Foundation

struct Ticket: Codable {
    // MARK: - Properties
    let id: Int
    let subject: String
    let description: String
    let status: String
}
