//
//  OHHTTPStubs+.swift
//  HiMetaTests
//
//  Created by Marcio Romero on 1/19/21.
//

import Foundation
import OHHTTPStubs

class NetworkStub {
    
    public static let instance = NetworkStub()
    
    public static let defaultRequestResponseTime = TimeInterval(0.5)

    public func defaultStub(urlEndsWith: String, jsonMock: String, type: AnyClass) {
        stub(condition: pathEndsWith(urlEndsWith) ) { _ in
            let stubPath = OHPathForFile("\(jsonMock).json", type)
            let response = fixture(filePath: stubPath ?? "",
                                   headers: ["Content-Type": "application/json"])
            response.requestTime = NetworkStub.defaultRequestResponseTime
            return response
        }
    }

    public func defaultStubServerDown(urlEndsWith: String, status: Int32 = 500) {
        stub(condition: pathEndsWith(urlEndsWith) ) { _ in
            let response = HTTPStubsResponse(
                jsonObject: [:],
                statusCode: status,
                headers: [ "Content-Type": "application/json" ]
            )
            response.requestTime = NetworkStub.defaultRequestResponseTime
            return response
        }
    }

    public func removeStubs() {
        HTTPStubs.removeAllStubs()
    }
}

