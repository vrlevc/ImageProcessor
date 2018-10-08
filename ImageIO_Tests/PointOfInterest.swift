//
//  PointOfInterest.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/4/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import Foundation

struct PointOfInterest: Codable, Equatable {
	
	var name: String
	
	public static func == (lhs: PointOfInterest, rhs: PointOfInterest) -> Bool {
		return lhs.name == rhs.name
	}
	
	init(name: String) {
		self.name = name
	}
}
