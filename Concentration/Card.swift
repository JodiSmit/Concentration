//
//  Card.swift
//  Concentration
//
//  Created by Jodi Smit on 4/4/19.
//  Copyright © 2019 Jodi Lovell. All rights reserved.
//

import Foundation

struct Card {
	
	var isFaceUp = false
	var isMatched = false
	var seenBefore = false
	var identifier: Int
	
	private static var identifierFactory = 0
	
	private static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return identifierFactory
	}
	
	init() {
		self.identifier = Card.getUniqueIdentifier()
	}
}
