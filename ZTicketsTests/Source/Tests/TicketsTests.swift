//
//  TicketsTests.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import XCTest
@testable import ZTickets

class TicketsTests: XCTestCase {
    // MARK: - Proprerties
    private var business = TicketsBusiness()
    
    override func setUp() {
        super.setUp()
        
        business.apiProvider = TicketsMockAPIProvider()
    }
    
    func testBusinessTickets() {
        let viewId = 123456
        
        business.tickets(viewId: viewId) { (result) in
            do {
                let tickets = try result()
                
                XCTAssertTrue(tickets.count == 45, "Unexpected tickets amuont")
                
                let firstTicket = tickets[0]
                
                XCTAssertEqual(firstTicket.id, 103, "Unexpected ticket Id")
                XCTAssertEqual(firstTicket.subject, "Ticket : 99", "Unexpected ticket subject")
                XCTAssertEqual(firstTicket.status, Status.new.rawValue, "Unexpected ticket status")
                XCTAssertEqual(firstTicket.description, "This is a test ticket", "Unexpected ticket description")
            } catch {
                XCTFail("Failure to unwrap API provider response")
            }
        }
    }
    
}
