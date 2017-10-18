//
//  ProcedureSpec.swift
//  ProceduresTests
//
//  Created by Arturs Derkintis on 17/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Nimble
import Quick
import RxSwift
@testable import Procedures

class ProcedureSpec: QuickSpec {
    override func spec() {
        describe("Test Response decong process") {
            context("Successfull decoding proccess") {
                it("Should successfully parse and decode Procedure object", closure: {
                    guard let data = self.validProcedureJSONData else { return }
                    let response = Response(data: data)
                    let decoded = response.decode(Procedure.self)
                    expect(decoded?.id).to(equal("id"))
                    expect(decoded?.name).to(equal("name"))
                    expect(decoded?.icon).to(equal("icon"))
                })
            }
            context("Failure in decoding process", {
                it("Should fail in decoding Procedure", closure: {
                    guard let data = self.invalidProcedureJSONData else { return }
                    let response = Response(data: data)
                    let decoded = response.decode(Procedure.self)
                    expect(decoded?.id).to(beNil())
                    expect(decoded?.name).to(beNil())
                    expect(decoded?.icon).to(beNil())
                })
            })
        }
    }
    var validProcedureJSONData: Data? {
        let jsonString = "{\"id\":\"id\",\"name\":\"name\",\"icon\":\"icon\"}"
        return jsonString.data(using: .utf8)
    }
    var invalidProcedureJSONData: Data? {
        let jsonString = "{\"ids\":\"id\",\"names\":\"name\",\"icons\":\"icon\"}"
        return jsonString.data(using: .utf8)
    }
}
