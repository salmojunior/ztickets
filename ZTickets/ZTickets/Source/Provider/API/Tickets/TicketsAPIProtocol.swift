//
//  TicketsAPIProtocol.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import Foundation

typealias TicketsCallback = (() throws -> [String:AnyObject]?) -> Void

protocol TicketsAPIProtocol {
    
    /// View tickets API Call
    ///
    /// - Parameters:
    ///   - viewId: View Id
    ///   - token: Base 64 authentication token
    ///   - completion: TicketsCallback
    func tickets(viewId: Int, token: String, completion: @escaping TicketsCallback)
}
