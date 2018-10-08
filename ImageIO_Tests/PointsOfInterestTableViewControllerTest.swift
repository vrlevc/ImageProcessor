//
//  PointsOfInterestTableViewControllerTest.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/4/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import XCTest

class PointsOfInterestTableViewControllerTest: XCTestCase {

    func testNotification() {
		
		let notificationCenter = NotificationCenter()
		let observer = PointsOfInterestTableViewController(notificationCenter: notificationCenter)
		XCTAssertFalse(observer.didHandleNotification)
		
		let name = CurrentLocationProvider.authChangeNotification
		notificationCenter.post(name: name, object: nil)
		
		XCTAssertTrue(observer.didHandleNotification)
    }

}
