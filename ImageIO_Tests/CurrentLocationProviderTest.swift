//
//  CurrentLocationProviderTest.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/4/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import XCTest
import CoreLocation

class CurrentLocationProviderTest: XCTestCase {

	func testNotifyAuthChanged() {
		
		let notificationCenter = NotificationCenter()
		let poster = CurrentLocationProvider(notificationCenter: notificationCenter)

		let name = CurrentLocationProvider.authChangeNotification
		
		var observer: AnyObject?
		let expectation = self.expectation(description: "auth changed notification")
		observer  = notificationCenter.addObserver(forName: name, object: poster, queue: .main)
		{ _ in
			NotificationCenter.default.removeObserver(observer!)
			expectation.fulfill()
		}

		poster.notifyAuthChanged()
		wait(for: [expectation], timeout: 0)
	}
	
//	func testNotifyAuthChangedWithXCTNSNotificationExpectation() {
//
//		let notificationCenter = NotificationCenter()
//		let poster = CurrentLocationProvider(notificationCenter: notificationCenter)
//
//		let name = CurrentLocationProvider.authChangeNotification
//		let expectation = XCTNSNotificationExpectation(name: name, object: poster, notificationCenter: notificationCenter)
//
//		poster.notifyAuthChanged()
//		wait(for: [expectation], timeout: 0)
//	}
	
	struct MockLocationFetcher: LocationFetcher {
		weak var loactionFetcherDelegate: LocationFetcherDelegate?
		var desiredAccuracy: CLLocationAccuracy = 0
		
		var handleRequestLoaction: (() -> CLLocation)?
		func requestLocation() {
			guard let loaction = handleRequestLoaction?() else { return }
			loactionFetcherDelegate?.locationFatcher(self, didUpdateLocations: [loaction])
		}
	}
	
	func testCheckCurrentLoaction() {
		var locationFetcher = MockLocationFetcher()
		let requestLoactionExpectation = expectation(description: "request location")
		locationFetcher.handleRequestLoaction = {
			requestLoactionExpectation.fulfill()
			return CLLocation(latitude: 37.3293, longitude: -121.8893)
		}
		let provider = CurrentLocationProvider(loactionFetcher: locationFetcher)
		let completionExpectation = expectation(description: "completeion")
		provider.checkCurrentLocation { isPointOfInterest in
			XCTAssertTrue(isPointOfInterest)
			completionExpectation.fulfill()
		}
		
		wait(for: [requestLoactionExpectation, completionExpectation], timeout: 1)
	}

}




















