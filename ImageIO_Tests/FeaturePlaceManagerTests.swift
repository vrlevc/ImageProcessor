//
//  FeaturePlaceManagerTests.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/8/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import XCTest

class FeaturePlaceManagerTests: XCTestCase {

	struct MockTimerScheduler: TimerScheduler {
		var handleAddTimer: ((_ timer: Timer) -> Void)?
		
		func add(_ timer: Timer, forMode mode: RunLoopMode) {
			handleAddTimer?( timer )
		}
	}
	
    func testscheduleNextPlace() {
		
		var timerScheduler = MockTimerScheduler()
		var timerDelay = TimeInterval(0)
		timerScheduler.handleAddTimer = { timer in
			timerDelay = timer.fireDate.timeIntervalSinceNow
			timer.fire()
		}
		
		let manager = FeaturePlaceManager(timerScheduler: timerScheduler)
		let beforePlace = manager.currentPlace
		manager.scheduleNextPlace()
		
		XCTAssertEqual(timerDelay, 10, accuracy: 1)
		XCTAssertNotEqual( manager.currentPlace, beforePlace )
    }
	
}
