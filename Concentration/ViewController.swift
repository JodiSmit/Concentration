//
//  ViewController.swift
//  Concentration
//
//  Created by Jodi Smit on 4/4/19.
//  Copyright © 2019 Jodi Lovell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var game: Concentration!

	var availableThemes: [String: [String]] = [
		"cats": ["😸","😹","😻","😼","🙀","😾","😽","😿", "😺"],
		"cuteAnimals": ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐮"],
		"sportsEquipment": ["⚽️", "🏒", "🏏", "🏀", "🎾", "🥌", "⚾️", "🏓", "🥊"],
		"athletes": ["⛷", "🏊🏻‍♀️", "⛹🏻‍♀️", "🏋🏼‍♂️", "🚴🏻‍♀️", "🤸🏻‍♀️", "🏂", "🤾🏻‍♂️", "🤼‍♀️"],
		"halloween": ["☠️", "🎃", "🧟‍♂️", "🧛🏻‍♀️", "🧟‍♀️", "💀", "👻", "🦇", "🕷"],
		"christmas": ["🎄", "🎅🏻", "🤶🏻", "☃️", "🍗", "🥧", "🍷", "🛷", "🎁"],
		"vehicles": ["🚗", "🚕", "🚌", "🚎", "🚒", "🚚", "🚐", "🚓", "🏍"],
	]
	
	private var newTheme: [String] {
		let randomIndex = Int(arc4random_uniform(UInt32(availableThemes.count)))
		print(randomIndex)
		let randomArray = Array(availableThemes.values)[randomIndex]
		return randomArray
	}
	
	private var numberOfPairsOfCards: Int {
			return (cardButtons.count + 1) / 2
	}
	
	var emojiChoices = [String]()
	var emoji = [Int: String]()
	
	@IBOutlet var cardButtons: [UIButton]!
	@IBOutlet weak var flipCountLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	
	@IBAction func touchCard(_ sender: UIButton) {
		if let cardNumber = cardButtons.firstIndex(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
			flipCountLabel.text = ("Flips: \(game.flipCount)")
			scoreLabel.text = ("Score: \(game.gameScore)")
		} else {
			print("Card not in valid range")
		}
	}
	
	@IBAction func newGameButtonTapped(_ sender: UIButton) {
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
	
	func updateViewFromModel() {
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
	
	func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
			emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
		}
		
		
		return emoji[card.identifier] ?? "?"
	}
	
	func gameSetup() {
		game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
		emojiChoices = newTheme
		updateViewFromModel()
	}
}

