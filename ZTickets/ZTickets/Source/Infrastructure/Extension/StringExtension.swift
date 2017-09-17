//
//  StringExtension.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import Foundation

extension String {
    
    func base64() -> String? {
        // Transform String to Data with UTF8 encode
        guard let data = self.data(using: .utf8) else { return nil }
        // Get String from Data object in Base64
        let base64Encoded = data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        return base64Encoded
    }
}
