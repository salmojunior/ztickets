//
//  HandleError.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

/**
 *  Struct responsible to handle and show error to user, both business and technical errors
 */
struct HandleError {
    // MARK: - Public Functions
    
    static func handle(error: Error) {
        
        if let businessError = error as? BusinessError {
            handleBusiness(error: businessError)
        }
        else if let technicalError = error as? TechnicalError {
            handleTechnical(error: technicalError)
        } else {
            print("Unknowed erro type")
        }
    }
    
    // MARK: - Handle Error types
    
    /**
     Handle all types of BusinessError
     
     - parameter error:                BusinessError object
     - parameter navigationController: Instance of current navigationController
     */
    private static func handleBusiness(error: BusinessError) {
        print(error.localizedDescription)
    }
    
    /**
     Handle all types of TechnicalError
     
     - parameter error:                TechnicalError object
     - parameter navigationController: Instance of current navigationController
     */
    private static func handleTechnical(error: TechnicalError) {
        print(error.localizedDescription)
    }
}
