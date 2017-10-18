//
//  TargetType.swift
//  Procedures
//
//  Created by Arturs Derkintis on 17/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation

/// Endpoint protocol
protocol TargetType {

    /// Base Url for endpoint
    var baseURL: URL { get }

    // Path of the endpoint
    var path: String { get }

    // HTTP method
    var method: Method { get }
}

// HTTP methods
enum Method: String{
    case GET, POST, DELETE
}
