//
//  GameViewController.swift
//  wordGame
//
//  Created by Sangeeta van Beemen on 15/05/15 W20.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

// variables and constants to load dictionary and game instances
let path = NSBundle.mainBundle().pathForResource("english", ofType: "txt")
var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
let currentDictionary = Dictionary(wordList: text)
let currentGame = Game(gameDictionary: currentDictionary)

class GameViewController: UIViewController
{
    
    // UILabel player1
    @IBOutlet weak var playerOneLabel: UILabel!
    
    // UILabel player2
    @IBOutlet weak var playerTwoLabel: UILabel!
    
    // UILabel display lettersPlayed
    @IBOutlet weak var lettersPlayedDisplay: UILabel!
    
    // variable for play button. determines how it looks and when enabled.
    @IBOutlet weak var playButton: UIButton!
    
    // variable for delete button
    @IBOutlet weak var deleteButton: UIButton!
    
    // variable for letter buttons
    @IBOutlet var alphaButtons: [UIButton]!
    
    // title of letterButton
    var letter: String!
    
    var gameInProgress: Bool
    
    
    required init(coder aDecoder: NSCoder)
    {
        if var gameInProgress = defaults.objectForKey("gameInProgress") as? Bool
        {
            self.gameInProgress = gameInProgress
        }
        else
        {
            self.gameInProgress = false
        }
        
        super.init(coder: aDecoder)
    }
    

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)

        println("game in progress")
        println(self.gameInProgress)
        
        // restores game to state it was left in
        if self.gameInProgress
        {
            lettersPlayedDisplay.text = defaults.objectForKey("currentLettersPlayed") as? String
            currentGame.playerOneTurn = defaults.objectForKey("currentPlayerOneTurn") as! Bool
            currentGame.gameDictionary.filterDictionary = defaults.objectForKey("currentFilterDictionary") as! [String]
            println("view should show text")
            println(currentGame.playerOneTurn)
        }
        
        self.playerOneLabel.text = defaults.objectForKey("currentPlayerOne") as? String
        self.playerTwoLabel.text = defaults.objectForKey("currentPlayerTwo") as? String
        
        // highlight the correct players label
        self.playerOneLabel.highlighted = currentGame.playerOneTurn
        self.playerTwoLabel.highlighted = !currentGame.playerOneTurn
    }
    
    
    override func viewWillDisappear(animated: Bool)
    {
        println("inside view will dissapear")
        
        self.gameInProgress = true
        
        println(self.gameInProgress)
        
        defaults.setObject(gameInProgress, forKey: "gameInProgress")
        
        println("set object defaults")
        
        saveGameState()
    }
    
    @IBAction func pressPlayButton(sender: UIButton)
    {
        // send content display to game class to filter dictionary
        currentGame.guess(lettersPlayedDisplay.text!)
        
        // disable delete and play buttons
        deleteButton.enabled = false
        playButton.enabled = false
        playButton.highlighted = true

        // check if gameOver
        if currentGame.ended()
        {
            // checks who won
            currentGame.winner()
            if currentGame.playerOneWinner
            {
                println("player one wins!")
            }
            else
            {
                println("player two wins!")
            }
            
            self.gameInProgress = false
            currentGame.gameOver = false
            // resets game filtered dictionary to original content
            currentGame.gameDictionary.reset()
            self.lettersPlayedDisplay.text = ""
            
//            displayWinner()
        }
        
        // switch playerLabels to indicate who's turn
        switchPlayerLabelHighlight()
        currentGame.turn()
        
        // enables letter buttons so new letter can be played
        for button in alphaButtons
        {
            button.enabled = true
            button.highlighted = false
        }
    }
    
    // deletes input in textfield when deleteButton is pressed
    @IBAction func backSpaceButton(sender: UIButton)
    {
        // disables delete button once pressed
        deleteButton.enabled = false
        deleteButton.highlighted = false
        
        // allows only one letter to be removed
        let stringLength = count(lettersPlayedDisplay.text!)
        let substringIndex = stringLength - 1
        lettersPlayedDisplay.text = lettersPlayedDisplay.text!.substringToIndex(advance(lettersPlayedDisplay.text!.startIndex, substringIndex))
        
        // enables alpha buttons after deteled one letter
        for button in alphaButtons
        {
            button.enabled = true
            button.highlighted = false
        }
        
    }
    
    
    @IBAction func playedLetter(sender: UIButton)
    {
        // display player letter input in display
        letter = sender.currentTitle!
        lettersPlayedDisplay.text = lettersPlayedDisplay.text! + letter
        
        // disable letterButtons when one letter has been pressed
        checkInput()
    }
    
    
    // settings button => to settingsview/menu
    @IBAction func settingsButton(sender: UIButton)
    {
        
    }
    
    
    // highlight player of current player
    func switchPlayerLabelHighlight()
    {
        playerOneLabel.highlighted = !playerOneLabel.highlighted
        playerTwoLabel.highlighted = !playerTwoLabel.highlighted
    }
    

    // enables and disables buttons for valid input
    func checkInput()
    {
        // enables playButton when 1 letter has been entered
        if count(letter) == 1
        {
            for button in alphaButtons
            {
                button.enabled = false
                button.highlighted = true
                
            }
            playButton.enabled = true
            playButton.highlighted = false
            
            deleteButton.enabled = true
            deleteButton.highlighted = false
        }
    }
    
    
    // save data of current game
    func saveGameState()
    {
        defaults.setObject(currentGame.playerOneTurn, forKey: "currentPlayerOneTurn")
        defaults.setObject(currentDictionary.filterDictionary, forKey: "currentFilterDictionary")
        defaults.setObject(lettersPlayedDisplay.text, forKey: "currentLettersPlayed")
        
        println("inside save stat")
        println(defaults.objectForKey("currentPlayerOneTurn"))
        println(defaults.objectForKey("currentFilterDictionary"))
        println(defaults.objectForKey("currentLettersPlayed"))

    }
    
//    func displayWinner()
//    {
//        var nameWinner: String
//        println("inside displayWinner")
//        
//        if currentGame.playerOneWinner
//        {
//            nameWinner = self.playerOneLabel.text!
//            println(self.playerOneLabel.text!)
//            
//        }
//        else
//        {
//            nameWinner = playerTwoLabel.text!
//             println(self.playerTwoLabel.text!)
//        }
//        // instantiate a gameScene when startGameButton is pressed
//        let winnerView = self.storyboard?.instantiateViewControllerWithIdentifier("winnerScene") as! WinnerViewController
//        winnerView.winnerMessageLabel.text! = nameWinner
//        self.navigationController?.pushViewController(winnerView, animated: true)
//    }
}

