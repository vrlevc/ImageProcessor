//
//  FeaturePlaceManager.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/8/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import Foundation

class FeaturePlaceManager {
	
	var currentPlace: Place
	let timerScheduler: TimerScheduler
	
	init(timerScheduler: TimerScheduler = RunLoop.current) {
		currentPlace = Place(name: "default")
		self.timerScheduler = timerScheduler
	}
	
	
	func scheduleNextPlace() {
		// Show next place after 10 second
		let timer = Timer(timeInterval: 10, repeats: false) { [weak self] _ in
			self?.showNextPlace()
		}
		timerScheduler.add(timer, forMode: .defaultRunLoopMode)
	}
	
	func showNextPlace() {
		currentPlace = Place(name: "updated")
	}
}

protocol TimerScheduler {
	func add(_ timer: Timer, forMode mode: RunLoopMode)
}

extension RunLoop: TimerScheduler {}



























