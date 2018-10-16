//
//  TicketsMockAPIProvider.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import Foundation
@testable import ZTickets

class TicketsMockAPIProvider: TicketsAPIProtocol {
    // MARK: - Constants
    
    private let kMockingFilesExtension = "json"
    private let kMockingTicketsFileName = "tickets"
    
    // MARK: - Mocking Movies Service Functions
    
    /// View tickets API Call
    ///
    /// - Parameters:
    ///   - viewId: View Id
    ///   - token: Base 64 authentication token
    ///   - completion: TicketsCallback
    func tickets(viewId: Int, token: String, completion: @escaping TicketsCallback) {
        let testBundle = Bundle(for: type(of: self))
        
        guard let path = testBundle.path(forResource: kMockingTicketsFileName, ofType: kMockingFilesExtension) else {
            completion { throw TechnicalError.parse(kMockingTicketsFileName) }
            
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let resultDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
            
            completion { resultDictionary }
        } catch {
            completion { throw TechnicalError.requestError }
        }
    }
}
