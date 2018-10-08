//
//  APILoaderTest.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/4/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import XCTest

class APILoaderTest: XCTestCase {

	var loader: APIRequestLoader<PointOfInterestRequest>!
	
    override func setUp() {
        super.setUp()
		
		let request = PointOfInterestRequest()
		
		let configuration = URLSessionConfiguration.ephemeral
		configuration.protocolClasses = [MockURLProtocol.self]
		let urlSession = URLSession(configuration: configuration)
		
		loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
    }

	func testLoaderSuccess() {
		let inputCoordinate = CLLocationCoordinate2D(latitude: 37.3293, longitude: -121.8893)
		let mockJSONData = "[{\"name\":\"MyPointOfInterest\"}]".data(using: .utf8)!
		MockURLProtocol.requestHandler = { request in
			XCTAssertEqual(request.url?.query?.contains("lat=37.3293"), true)
			return (HTTPURLResponse(), mockJSONData)
		}
		
		let expectation = XCTestExpectation(description: "response")
		loader.loadAPIRequest(requestData: inputCoordinate) { (pointsOfInterest, error) in
			XCTAssertEqual(pointsOfInterest, [PointOfInterest(name: "MyPointOfInterest")])
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1)
	}
}



























