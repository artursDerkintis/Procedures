//
//  OnlineProvider.swift
//  Procedures
//
//  Created by Arturs Derkintis on 18/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation
import RxSwift


/// Simple errors
///
/// - noData: API haven't returned any data
/// - parsingError: There's somehting happened durring decoding
enum ProcedureError: Error {
    case noData, parsingError
}

/// Universal helper that requests data from API using supported endpoints and returns desired Response
class OnlineProvider<Target> where Target: TargetType  {

    /// Makes request to API using URLSession and returns outcome
    ///
    /// - Parameters:
    ///   - target: Endpoint
    ///   - type: Desired Model type
    /// - Returns: Observable Model
    public func request<T: Codable>(_ target: Target, type: T.Type) -> Observable<T> {
        let url = target.baseURL.appendingPathComponent(target.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = target.method.rawValue
        return Observable.create({ observer in

            let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
                if let error = error {
                    observer.on(.error(error))
                    observer.on(.completed)
                    return
                }
                guard let data = data else {
                    observer.on(.error(ProcedureError.noData))
                    observer.on(.completed)
                    return
                }
                let response = Response(data: data)
                guard let decoded = response.decode(type) else {
                    observer.on(.error(ProcedureError.parsingError))
                    observer.on(.completed)
                    return
                }
                observer.on(.next(decoded))
                observer.on(.completed)
            }

            urlSession.resume()
            return Disposables.create()
        })

    }
}
