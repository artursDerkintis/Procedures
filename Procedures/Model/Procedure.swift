//
//  Procedure.swift
//  Procedures
//
//  Created by Arturs Derkintis on 17/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation

/// Procedure Model
struct Procedure: Codable {
    let name: String
    let id: String
    let icon: String
}

/// ProcedureDetails Model
struct ProcedureDetails: Codable {
    let name: String
    let id: String
    let icon: String
    let card: String
    let phases: [Phase]
}
