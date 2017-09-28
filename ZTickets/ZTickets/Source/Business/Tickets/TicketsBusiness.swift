//
//  TicketsBusiness.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import Foundation
import UIKit

typealias TicketsUICallback = (() throws -> [Ticket]) -> Void
    
struct TicketsBusiness {
    // MARK: - Constants
    
    private let ticketsKey = "tickets"
    private let user = "acooke+techtest@zendesk.com"
    private let password = "mobile"
    
    // MARK: - Properties
    
    var apiProvider: TicketsAPIProtocol = TicketsAPIProvider()
    
    // MARK: - Public Methods
    
    func tickets(viewId: Int, completion: @escaping TicketsUICallback) {
        guard let token = "\(user):\(password)".base64() else {
            completion { throw BusinessError.invalidValue }
            
            return
        }
        
        apiProvider.tickets(viewId: viewId, token: token) { (result) in
            do {
                guard let response = try result() else {
                    completion { throw TechnicalError.requestError }
                    
                    return
                }
                guard let ticketsDic = response[self.ticketsKey] as? [[String: Any]] else {
                    completion { throw TechnicalError.requestError }
                    
                    return
                }
                
                let data: Data = try JSONSerialization.data(withJSONObject: ticketsDic, options: .prettyPrinted)
                let tickets = try JSONDecoder().decode([Ticket].self, from: data)
                
                completion { tickets }
            } catch {
                completion { throw error }
            }
        }
    }
}
