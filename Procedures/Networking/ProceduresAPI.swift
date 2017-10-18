//
//  ProceduresAPI.swift
//  Procedures
//
//  Created by Arturs Derkintis on 17/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation


/// Endpoints
///
/// - procedures: Returns [Procedure]
/// - procedureDetails: Returns [ProcedureDetails]
enum ProceduresAPI {
    case procedures
    case procedureDetails
}


// MARK: - Assign values to endpoint enum
extension ProceduresAPI: TargetType {

    var method: Method {
        switch self {
        case .procedures, .procedureDetails:
            return .GET
        }
    }

    var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }

    var path: String {
        switch self {
        case .procedures:
            return "/procedures"
        case .procedureDetails:
            return "/procedure_details"
        }
    }

}


