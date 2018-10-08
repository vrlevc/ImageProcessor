//
//  Place.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/8/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import Foundation

struct Place {
	
	var name: String

	public static func == (lhs: Place, rhs: Place) -> Bool {
		return lhs.name == rhs.name
	}

	init(name: String) {
		self.name = name
	}
}

extension Place: Equatable {}

