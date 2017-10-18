//
//  ProcedureDetailsViewModel.swift
//  Procedures
//
//  Created by Arturs Derkintis on 18/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation
import RxSwift

class ProcedureDetailsViewModel {
    private let disposeBag = DisposeBag()
    private let networking = Networking().provider

    /// The specific id of Procedure this viewModel should be handling
    public var id: String = ""

    /// Contains array of ProcedureDetails models
    public let procedureDetails = Variable<[ProcedureDetails]>([])

    /// Contains array of SectionOfType models which contains Phase items
    public let phases = Variable<[SectionOfType<Phase>]>([])


    /// Fetches the data from the API 
    public func loadData() {
        // There probably should've been better endpoint to just get the specific procedure details by 'id'
        /// Makes request to API
        let decodedResponse = networking.request(.procedureDetails, type: [ProcedureDetails].self)
        /// Listens to its response
        decodedResponse.subscribe { [weak self] event in
            switch event {
            case .next(let procedureDetails):
                self?.procedureDetails.value = procedureDetails
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

    /// Based on 'id' variable in this ViewModel filters out specific ProcedureDetails model from the 'procedureDetails' array
    ///
    /// - Returns: ProcedureDetails model object
    public func procedureDetailsById() -> ProcedureDetails? {
        guard let procedureDetails = self.procedureDetails.value.first(where: { $0.id == id }) else {
            return nil
        }
        phases.value = [SectionOfType(header: "", items: procedureDetails.phases)]
        return procedureDetails
    }
}
