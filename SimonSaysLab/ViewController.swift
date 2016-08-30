//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    @IBAction func redButton(sender: AnyObject) {
        simonSaysGame.guessRed()
        buttonsClicked += 1
        gameResults()
        
    }
    
    @IBAction func greenButton(sender: AnyObject) {
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        gameResults()
    }
    
    @IBAction func yellowButton(sender: AnyObject) {
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        gameResults()
    }
    
    @IBAction func blueButton(sender: AnyObject) {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        gameResults()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.hidden = true
    }
    
    func gameResults() {
        if (simonSaysGame.wonGame() == true) && buttonsClicked >= 5 {
            winLabel.text = "You won!"
            winLabel.hidden = false
            startGameButton.hidden = false
            buttonsClicked = 0
            
        } else if (simonSaysGame.wonGame() == false) && buttonsClicked >= 5 {
            winLabel.text = "Nope, try again."
            winLabel.hidden = false
            startGameButton.hidden = false
            buttonsClicked = 0
        }
    }

}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(sender: UIButton) {
        UIView.transitionWithView(startGameButton, duration: 0.9, options: .TransitionFlipFromBottom , animations: {
            self.startGameButton.hidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    private func displayTheColors() {
        self.view.userInteractionEnabled = false
        UIView.transitionWithView(displayColorView, duration: 1.5, options: .TransitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.userInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
