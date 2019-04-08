//
//  Concentration.swift
//  Concentration
//
//  Created by Jodi Smit on 4/4/19.
//  Copyright © 2019 Jodi Lovell. All rights reserved.
//

import Foundation

class Concentration {
	var cards = [Card]()
	var indexOfOneAndOnlyFaceUpCard: Int? {
		get {
			var foundIndex: Int?
			for index in cards.indices {
				if cards[index].isFaceUp {
					if foundIndex == index {
						foundIndex = index
					} else {
						return nil
					}
				}
			}
			return foundIndex
		}
		set {
			for index in cards.indices {
				cards[index].isFaceUp = (index == newValue)
			}
		}
	}
	var flipCount = 0
	var gameScore = 0
	var cardsSeen = [Int]()
	
	func chooseCard(at index: Int) {
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
					gameScore += 2
				} else {
					if cards[index].seenBefore || cards[matchIndex].seenBefore {
						gameScore -= 1
					}
					cards[index].seenBefore = true
					cards[matchIndex].seenBefore = true
				}
				cards[index].isFaceUp = true
			} else {
				indexOfOneAndOnlyFaceUpCard = index
			}
			
		}
		
		flipCount += 1
	}
	
	func newGame() {
		indexOfOneAndOnlyFaceUpCard = nil
	}
	
	init(numberOfPairsOfCards: Int) {
		for _ in 0..<numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
		}
		cards.shuffle()
	}
}
