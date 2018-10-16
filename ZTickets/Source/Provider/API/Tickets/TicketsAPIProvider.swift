//
//  TicketsAPIProvider.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import Foundation

class TicketsAPIProvider: TicketsAPIProtocol {
    
    // MARK: - Constants
    private let view = "/views/"
    private let tickets = "/tickets.json"
    
    // MARK: - Public Methods
    
    /// View tickets API Call
    ///
    /// - Parameters:
    ///   - viewId: View Id
    ///   - token: Base 64 authentication token
    ///   - completion: TicketsCallback
    func tickets(viewId: Int, token: String, completion: @escaping TicketsCallback) {
        let authValue = APIProvider.authValue + " " + token
        let header = [APIProvider.authKey:authValue]
        let ticketsEndpoint = view + String(viewId) + tickets
        
        let _ = APIProvider.sharedProvider.GET(ticketsEndpoint, parameters: nil, header: header) { (result) in
            completion {
                return try result()
            }
        }
    }
}
