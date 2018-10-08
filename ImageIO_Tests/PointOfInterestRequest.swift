//
//  PointOfInterestRequest.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/4/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import Foundation

enum RequestError : Error {
	case invalidCoordinate
}

class PointOfInterestRequest: APIRequest {
	
	func CLLocationCoordinate2DIsValid(_: CLLocationCoordinate2D) -> Bool {
		return true;
	}
	
	func makeRequest(from coordinate: CLLocationCoordinate2D) throws -> URLRequest {
		guard CLLocationCoordinate2DIsValid(coordinate) else {
			throw RequestError.invalidCoordinate
		}
		
		var components = URLComponents(string: "https://example.com/locations")!
		components.queryItems = [
			URLQueryItem(name: "lat", value: "\(coordinate.latitude)"),
			URLQueryItem(name: "long", value: "\(coordinate.longitude)")
		]
		return URLRequest(url: components.url!)
	}
	
	func parseResponce(data: Data) throws -> [PointOfInterest] {
		return try JSONDecoder().decode([PointOfInterest].self, from: data)
	}
}
