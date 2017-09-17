//
//  BusinessError.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

enum BusinessError: Error {
    case parse(String)
    case invalidValue
    case invalidDictionaryKey(String)
}
