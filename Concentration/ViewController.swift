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
	
	var flipCount = 0 {
		didSet {
			flipCountLabel.text = "Flips: \(flipCount)"
		}
	}
	var emojiChoices = ["👹", "👺", "😈", "☠️", "🤖", "👽", "👾", "🎃", "🧟‍♂️"]
	var emoji = [Int: String]()
	
	@IBOutlet var cardButtons: [UIButton]!
	@IBOutlet weak var flipCountLabel: UILabel!
	
	@IBAction func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.firstIndex(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("Card not in valid range")
		}
	}
	
	@IBAction func newGameButtonTapped(_ sender: UIButton) {
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
		game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
		updateViewFromModel()
	}
}

