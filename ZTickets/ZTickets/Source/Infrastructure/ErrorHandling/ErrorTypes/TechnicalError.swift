//
//  TechnicalError.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

enum TechnicalError: Error {
    case parse(String)
    case httpError(Int)
    case requestError
    case invalidURL
    case notFound
    case notConnected
}
