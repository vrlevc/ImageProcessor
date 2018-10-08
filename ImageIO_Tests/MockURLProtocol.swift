//
//  MocURLProtocol.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/4/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import Foundation
import XCTest

class MockURLProtocol: URLProtocol {
	
	static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
	
	override class func canInit(with request: URLRequest) -> Bool {
		return true
	}
	
	override class func canonicalRequest(for request: URLRequest) -> URLRequest {
		return request
	}
	
	override func startLoading() {
		guard let handler = MockURLProtocol.requestHandler else {
			XCTFail("Received unexpected request with no handler set")
			return
		}
		do {
			let (responce, data) = try handler(request)
			client?.urlProtocol(self, didReceive: responce, cacheStoragePolicy: .notAllowed)
			client?.urlProtocol(self, didLoad: data)
			client?.urlProtocolDidFinishLoading(self)
		} catch {
			client?.urlProtocol(self, didFailWithError: error)
		}
	}
	
	override func stopLoading() {
		// ...
	}
}
































