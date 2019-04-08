//
//  ViewController.swift
//  Concentration
//
//  Created by Jodi Smit on 4/4/19.
//  Copyright © 2019 Jodi Lovell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	private var game: Concentration!

	private var availableThemes: [String: [String]] = [
		"cats": ["😸","😹","😻","😼","🙀","😾","😽","😿", "😺"],
		"cuteAnimals": ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐮"],
		"sportsEquipment": ["⚽️", "🏒", "🏏", "🏀", "🎾", "🥌", "⚾️", "🏓", "🥊"],
		"athletes": ["⛷", "🏊🏻‍♀️", "⛹🏻‍♀️", "🏋🏼‍♂️", "🚴🏻‍♀️", "🤸🏻‍♀️", "🏂", "🤾🏻‍♂️", "🤼‍♀️"],
		"halloween": ["☠️", "🎃", "🧟‍♂️", "🧛🏻‍♀️", "🧟‍♀️", "💀", "👻", "🦇", "🕷"],
		"christmas": ["🎄", "🎅🏻", "🤶🏻", "☃️", "🍗", "🥧", "🍷", "🛷", "🎁"],
		"vehicles": ["🚗", "🚕", "🚌", "🚎", "🚒", "🚚", "🚐", "🚓", "🏍"],
	]
	
	private var newTheme: [String] {
		let randomArray = Array(availableThemes.values)[availableThemes.count.arc4Random]
		return randomArray
	}
	
	var numberOfPairsOfCards: Int {
			return (cardButtons.count + 1) / 2
	}
	
	private var emojiChoices = [String]()
	private var emoji = [Int: String]()
	
	@IBOutlet private var cardButtons: [UIButton]!
	@IBOutlet private weak var flipCountLabel: UILabel!
	@IBOutlet private weak var scoreLabel: UILabel!
	
	@IBAction private func touchCard(_ sender: UIButton) {
		if let cardNumber = cardButtons.firstIndex(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
			flipCountLabel.text = ("Flips: \(game.flipCount)")
			scoreLabel.text = ("Score: \(game.gameScore)")
		} else {
			print("Card not in valid range")
		}
	}
	
	@IBAction private func newGameButtonTapped(_ sender: UIButton) {
		game.flipCount = 0
		game.gameScore = 0
		flipCountLabel.text = ("Flips: 0")
		scoreLabel.text = ("Score: 0")
		gameSetup()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		gameSetup()
	}
	
	private func updateViewFromModel() {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: .normal)
				button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			} else {
				button.setTitle("", for: .normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
			}
		}
	}
	
	private func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4Random)
		}
		
		
		return emoji[card.identifier] ?? "?"
	}
	
	func gameSetup() {
		game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
		emojiChoices = newTheme
		updateViewFromModel()
	}
}

extension Int {
	var arc4Random: Int {
		if self > 0 {
			return Int(arc4random_uniform(UInt32(self)))
		} else if self < 0 {
			return -Int(arc4random_uniform(UInt32(abs(self))))
		} else {
			return 0
		}
	}
}
