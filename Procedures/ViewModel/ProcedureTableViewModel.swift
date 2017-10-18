//
//  ProcedureTableViewModel.swift
//  Procedures
//
//  Created by Arturs Derkintis on 17/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import RxSwift

class ProcedureTableViewModel {
    private let disposeBag = DisposeBag()
    private let networking = Networking().provider

    /// Contains array of SectionOfType models which countains Procedure items
    public let procedures = Variable<[SectionOfType<Procedure>]>([])

    /// Fetches the data from the API
    public func loadData() {
        /// Makes request to API
        let decodedResponse = networking.request(.procedures, type: [Procedure].self)
        /// Listens to its response
        decodedResponse.subscribe { [weak self] event in
            switch event {
            case .next(let procedures):
                self?.procedures.value = [SectionOfType(header: "", items: procedures)]
                break
            case .error(let error):
                print(error.localizedDescription)
                // TODO: some error handling should be implemented
                break
            default:
                return
            }
        }.disposed(by: disposeBag)
    }

    /// Based on IndexPath from TableView filters out specific Procedure item out of 'procedures' dictionary
    ///
    /// - Parameter indexPath: IndexPath passed from selected cell of TableView
    /// - Returns: Procedure model
    public func procedure(indexPath: IndexPath) -> Procedure? {
        return procedures.value[indexPath.section].items[indexPath.row]
    }
}
