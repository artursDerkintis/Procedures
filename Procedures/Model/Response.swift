//
//  Response.swift
//  Procedures
//
//  Created by Arturs Derkintis on 17/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation

/// Universal Respose model
struct Response {
    
    fileprivate let data: Data
    
    /// Init with data from API response
    ///
    /// - Parameter data: Data received from API
    public init(data: Data) {
        self.data = data
    }
}

// MARK: - Decoding logic
extension Response {

    /// Decodes data into desired Model that conforms to Codable protocol
    ///
    /// - Parameter type: Type of Model that conforms to Codable protocol
    /// - Returns: Desired Model that conforms to Codable protocol
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch _ {
            return nil
        }
    }
}

