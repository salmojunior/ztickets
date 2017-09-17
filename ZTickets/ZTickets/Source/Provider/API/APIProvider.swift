//
//  APIProvider.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import Foundation

struct APIProvider {
    // MARK: - Constants
    
    /// API version
    private static let apiVersion = "v2"
    /// Auth header Key
    static let authKey = "Authorization"
    static let authValue = "Basic"
    
    /// Shared Networking Provider used to access API Services
    static var sharedProvider: NetworkingProvider {
        let urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
        guard let baseURL = URL(string: APIProvider.baseURL()) else { fatalError("Base URL should not be empty") }
        
        return NetworkingProvider(session: urlSession, baseURL: baseURL)
    }
    
    // MARK: - Public Static Functions
    
    /// API Base URL
    ///
    /// - Returns: return baseURL
    private static func baseURL() -> String {
        return "https://mxtechtest.zendesk.com/api/" + apiVersion
    }
}
