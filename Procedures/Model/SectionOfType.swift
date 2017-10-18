//
//  SectionOfType.swift
//  Procedures
//
//  Created by Arturs Derkintis on 18/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation
import RxDataSources

/// Section data model for TableView
struct SectionOfType<T: Codable> {
    var header: String
    var items: [Item]
}

extension SectionOfType: SectionModelType {
    typealias Item = T
    init(original: SectionOfType, items: [Item]) {
        self = original
        self.items = items
    }

}
