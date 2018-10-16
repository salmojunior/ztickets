//
//  NetworkingProvider.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import Foundation

/// Typealias

public typealias NetworkingDictionaryCompletion = (() throws -> [String:AnyObject]?) -> ()
public typealias NetworkingArrayCompletion = (() throws -> [AnyObject]?) -> ()
public typealias NetworkingParameters = (bodyParameters: [String:AnyObject]?, queryParameters: [String:String]?)

/// Service HTTP Method
///
/// - get: GET Verb
/// - post: POST Verb
/// - head: HEAD Verb
/// - put: PUT Verb
/// - delete: DELETE Verb
enum ServiceHTTPMethod : String {
    case get = "GET"
    case post = "POST"
    case head = "HEAD"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkingProvider {
    
    private let session: URLSession
    private let baseURL: URL
    
    
    /// Provider Networking Initializer
    ///
    /// - Parameters:
    ///   - session: URLSession
    ///   - baseURL: URL
    init(session: URLSession, baseURL: URL) {
        self.session = session
        self.baseURL = baseURL
    }
    
    //MARK: - HTTP Verbs
    
    /// GET request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: Dictionary
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func GET(_ url: String, parameters: NetworkingParameters?, header: [String:String]?, completionWithDictionary completion: @escaping NetworkingDictionaryCompletion) -> URLSessionTask? {
        
        return self.dataTaskFor(httpMethod: .get, url: url, parameters: parameters, header: header, completion: completion)
    }
    
    
    /// GET request with Array response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: Dictionary
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func GET(_ url: String, parameters: NetworkingParameters?, header: [String:String]?, completionWithArray completion: @escaping NetworkingArrayCompletion) -> URLSessionTask? {
        
        return self.dataTaskFor(httpMethod: .get, url: url, parameters: parameters, header: header, completion: completion)
    }
    
    
    /// POST request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: Dictionary
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func POST(_ url: String, parameters: NetworkingParameters?, header: [String:String], completion: @escaping NetworkingDictionaryCompletion) -> URLSessionTask? {
        
        return self.dataTaskFor(httpMethod: .post, url: url, parameters: parameters, header: header, completion: completion)
    }
    
    
    /// HEAD request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: Dictionary
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func HEAD(_ url: String, parameters: NetworkingParameters?, header: [String:String], completion: @escaping NetworkingDictionaryCompletion) -> URLSessionTask? {
        
        return self.dataTaskFor(httpMethod: .head, url: url, parameters: parameters, header: header, completion: completion)
    }
    
    
    /// PUT request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: Dictionary
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func PUT(_ url: String, parameters: NetworkingParameters?, header: [String:String], completion: @escaping NetworkingDictionaryCompletion) -> URLSessionTask? {
        
        return self.dataTaskFor(httpMethod: .put, url: url, parameters: parameters, header: header, completion: completion)
    }
    
    
    /// DELETE request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: Dictionary
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func DELETE(_ url: String, parameters: NetworkingParameters?, header: [String:String], completion: @escaping NetworkingDictionaryCompletion) -> URLSessionTask? {
        
        return self.dataTaskFor(httpMethod: .delete, url: url, parameters: parameters, header: header, completion: completion)
    }
    
    //MARK: - Private methods
    
    private func request(_ urlPath: String, parameters: NetworkingParameters?, header: [String:String]?, httpMethod: ServiceHTTPMethod) throws -> URLRequest {
        let request = NSMutableURLRequest()
        request.httpMethod = httpMethod.rawValue
        
        guard let completeURL = self.completeURL(urlPath) else { throw TechnicalError.invalidURL }
        guard var urlComponents : URLComponents = URLComponents(url: completeURL, resolvingAgainstBaseURL: false) else { throw TechnicalError.invalidURL }
        
        //checking if parameters are needed
        if let params = parameters {
            //adding parameters to body
            if let bodyParameters = params.bodyParameters {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
            }
            
            //adding parameters to query string
            if let queryParameters = params.queryParameters {
                let parametersItems: [String] = queryParameters.map({ (par) -> String in
                    let value = par.1 != "" ? par.1 : "null"
                    
                    return "\(par.0)=\(value)"
                })
                
                urlComponents.query = parametersItems.joined(separator: "&")
            }
        }
        
        //setting url to request
        request.url = urlComponents.url
        request.cachePolicy = .reloadIgnoringCacheData
        
        //adding HEAD parameters
        if header != nil {
            for parameter in header! {
                request.addValue(parameter.1, forHTTPHeaderField: parameter.0)
            }
        }
        
        return request as URLRequest
    }
    
    private func completeURL(_ componentOrUrl: String) -> URL? {
        if componentOrUrl.contains("http://") ||  componentOrUrl.contains("https://") {
            return URL(string: componentOrUrl)
        } else {
            return baseURL.appendingPathComponent(componentOrUrl)
        }
    }
    
    private func dataTaskFor(httpMethod: ServiceHTTPMethod, url: String, parameters: NetworkingParameters?, header: [String:String]?, completion: @escaping NetworkingDictionaryCompletion) -> URLSessionTask? {
        do {
            let request = try self.request(url, parameters: parameters, header: header, httpMethod: httpMethod)
            
            let sessionTask: URLSessionTask = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void  in
                self.completionHandler(data: data, response:response, error: error, completion: completion)
            })
            
            sessionTask.resume()
            
            return sessionTask
        } catch let errorRequest {
            DispatchQueue.main.async(execute: {
                completion { throw errorRequest }
            })
        }
        
        return nil
    }
    
    private func dataTaskFor(httpMethod: ServiceHTTPMethod, url: String, parameters: NetworkingParameters?, header: [String:String]?, completion: @escaping NetworkingArrayCompletion) -> URLSessionTask? {
        do {
            let request = try self.request(url, parameters: parameters, header: header, httpMethod: httpMethod)
            
            let sessionTask: URLSessionTask = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void  in
                self.completionHandler(data, response:response, error: error, completion: completion)
            })
            
            sessionTask.resume()
            
            return sessionTask
        } catch let errorRequest {
            DispatchQueue.main.async(execute: {
                completion { throw errorRequest }
            })
        }
        
        return nil
    }
    
    private func completionHandler(data: Data?, response: URLResponse?, error: Error?, completion: @escaping NetworkingDictionaryCompletion) {
        do {
            //check if there is no error
            if error != nil {
                throw error!
            }
            
            //unwraping httpResponse
            guard let httpResponse = response as? HTTPURLResponse else {
                throw TechnicalError.parse("The NSHTTPURLResponse could not be parsed")
            }
            
            //check if there is an httpStatus code ~= 200...299 (Success)
            if 200 ... 299 ~= httpResponse.statusCode {
                //trying to get the data
                guard let responseData = data else {
                    throw TechnicalError.parse("Problems on parsing Data from request: \(String(describing: httpResponse.url))")
                }
                
                //trying to parse
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves) as? NSDictionary else {
                    throw TechnicalError.parse("Problems on parsing JSON from request: \(String(describing: httpResponse.url))")
                }
                
                DispatchQueue.main.async(execute: {
                    //success
                    completion { json as? [String:AnyObject] }
                })
            } else {
                //checking status of http
                throw TechnicalError.httpError(httpResponse.statusCode)
                
            }
        } catch let errorCallback {
            DispatchQueue.main.async(execute: {
                completion { throw errorCallback }
            })
        }
    }
    
    private func completionHandler(_ data: Data?, response: URLResponse?, error: Error?, completion: @escaping NetworkingArrayCompletion) {
        do {
            //check if there is no error
            if error != nil {
                throw error!
            }
            
            //unwraping httpResponse
            guard let httpResponse = response as? HTTPURLResponse else {
                throw TechnicalError.parse("The NSHTTPURLResponse could not be parsed")
            }
            
            //check if there is an httpStatus code ~= 200...299 (Success)
            if 200 ... 299 ~= httpResponse.statusCode {
                //trying to get the data
                guard let responseData = data else {
                    throw TechnicalError.parse("Problems on parsing Data from request: \(String(describing: httpResponse.url))")
                }
                
                //trying to parse
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves) as? NSArray else {
                    throw TechnicalError.parse("Problems on parsing JSON from request: \(String(describing: httpResponse.url))")
                }
                
                DispatchQueue.main.async(execute: {
                    //success
                    completion { (json as [AnyObject]) }
                })
            } else {
                //checking status of http
                throw TechnicalError.httpError(httpResponse.statusCode)
                
            }
        } catch let errorCallback {
            DispatchQueue.main.async(execute: {
                completion { throw errorCallback }
            })
        }
    }
}
