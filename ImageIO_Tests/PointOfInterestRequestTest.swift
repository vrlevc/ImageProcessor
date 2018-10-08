//
//  PointOfInterestRequestTest.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/4/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import XCTest

class PointOfInterestRequestTest: XCTestCase {

	let request = PointOfInterestRequest()
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	// TEST:
	
	func testMakingURLRequest() throws {
		let coordinate  = CLLocationCoordinate2D(latitude: 37.3293, longitude: -121.8893)
		
		let urlRequest = try request.makeRequest(from: coordinate)
		
		XCTAssertEqual(urlRequest.url?.scheme, "https")
		XCTAssertEqual(urlRequest.url?.host, "example.com")
		XCTAssertEqual(urlRequest.url?.query, "lat=37.3293&long=-121.8893")
	}
	
	func testParsingResponse() throws {
		let jsonData = "[{\"name\":\"My Location\"}]".data(using: .utf8)!
		let response = try request.parseResponce(data: jsonData)
		XCTAssertEqual(response, [PointOfInterest(name: "My Location")])
	}
}
