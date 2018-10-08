//
//  CurrentLocationProvider.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/4/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentLocationProvider: NSObject {

	static let authChangeNotification = Notification.Name("AuthChanged")
	
	let notificationCenter: NotificationCenter
	init(notificationCenter: NotificationCenter = .default) {
		self.notificationCenter = notificationCenter
		self.loactionFetcher = CLLocationManager()
	}
	
	func notifyAuthChanged() {
		let name = CurrentLocationProvider.authChangeNotification
		notificationCenter.post(name: name, object: self)
	}

	var loactionFetcher: LocationFetcher
	init(loactionFetcher: LocationFetcher = CLLocationManager()) {
		self.notificationCenter = NotificationCenter.default
		self.loactionFetcher = loactionFetcher
		super.init()
		self.loactionFetcher.desiredAccuracy = kCLLocationAccuracyHundredMeters
		self.loactionFetcher.loactionFetcherDelegate = self
	}
	
	var currentLocationCheckCallback: ((CLLocation) -> Void)?
	func checkCurrentLocation(completion: @escaping (Bool) -> Void) {
		self.currentLocationCheckCallback = { [unowned self] loaction in
			completion(self.isPointOfInterest(loaction))
		}
		loactionFetcher.requestLocation()
	}
	
	func isPointOfInterest(_ loaction: CLLocation) -> Bool {
		return true;
	}
}

protocol LocationFetcher {
	var loactionFetcherDelegate: LocationFetcherDelegate? { get set }
	// CLLocationManager
	var desiredAccuracy: CLLocationAccuracy { get set }
	func requestLocation()
}
protocol LocationFetcherDelegate: class {
	func locationFatcher(_ fetcher: LocationFetcher, didUpdateLocations locations: [CLLocation])
}
extension CLLocationManager: LocationFetcher {
	var loactionFetcherDelegate: LocationFetcherDelegate? {
		get { return delegate as! LocationFetcherDelegate? }
		set { delegate = newValue as! CLLocationManagerDelegate? }
	}
}

extension CurrentLocationProvider: LocationFetcherDelegate {
	func locationFatcher(_ fetcher: LocationFetcher, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		self.currentLocationCheckCallback?(location)
		self.currentLocationCheckCallback = nil
	}
}

extension CurrentLocationProvider: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		self.locationFatcher(manager, didUpdateLocations: locations)
	}
}

extension CLLocationManager {
	func requestLocation() {
		
	}
}














