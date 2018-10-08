//
//  PointsOfInterestTableViewController.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/4/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import Foundation

class PointsOfInterestTableViewController {

	let notificationCenter: NotificationCenter
	var observer: AnyObject?
	
	init(notificationCenter: NotificationCenter = .default) {
		self.notificationCenter = notificationCenter
		let name = CurrentLocationProvider.authChangeNotification
		observer =  notificationCenter.addObserver(forName: name, object: nil, queue: .main)
					{ [weak self] _ in
						self?.handleAuthChange()
					}
	}
	
	var didHandleNotification = false
	func handleAuthChange() {
		didHandleNotification = true
	}
}














