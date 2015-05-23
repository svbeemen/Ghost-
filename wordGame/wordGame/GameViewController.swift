//
//  GameViewController.swift
//  Ghost
//
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//
//  naam: Sangeeta van Beemen
//  studentnummer: 10340521
//

import UIKit
//
//// variables and constants to load dictionary and game instances
//let language = defaults.valueForKey("language") as! String
//let path = NSBundle.mainBundle().pathForResource(language, ofType: "txt")
//let text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
//let currentDictionary = Dictionary(wordList: text)
//let currentGame = Game(gameDictionary: currentDictionary)

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
    
    // bool to indicate if a game is/was being played
    var gameInProgress: Bool
    
    // variables and constants to load dictionary and game instances
    let language: String
    let path: String
    let text: String
    let currentDictionary: Dictionary
    let currentGame: Game
    
    
    // check defaults if game was in progress
    required init(coder aDecoder: NSCoder)
    {
        // retrieve value of bool from defaults
        if var gameInProgress = defaults.objectForKey("gameInProgress") as? Bool
        {
            self.gameInProgress = gameInProgress
        }
        else
        {
            self.gameInProgress = false
        }
        
        
        // variables and constants to load dictionary and game instances
        self.language = defaults.valueForKey("language") as! String
        self.path = NSBundle.mainBundle().pathForResource(language, ofType: "txt")!
        self.text = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
        self.currentDictionary = Dictionary(wordList: text)
        self.currentGame = Game(gameDictionary: currentDictionary)
        
        super.init(coder: aDecoder)
    }
    
    
    // load view of game in appropriate state
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // if game was in progress restores that state
        if self.gameInProgress
        {
            // who's turn, lettersplayed and filterd gameDictionary
            lettersPlayedDisplay.text = defaults.objectForKey("currentLettersPlayed") as? String
            currentGame.playerOneTurn = defaults.objectForKey("currentPlayerOneTurn") as! Bool
            currentGame.gameDictionary.filterDictionary = defaults.objectForKey("currentFilterDictionary") as! [String]
        }
        else
        {
            // reset to a new game
            currentGame.playerOneTurn = true
            currentGame.gameDictionary.reset()
            lettersPlayedDisplay.text = ""
            currentGame.gameOver = false
        }

        // names of curreny players. only change when new game started
        self.playerOneLabel.text = defaults.objectForKey("currentPlayerOne") as? String
        self.playerTwoLabel.text = defaults.objectForKey("currentPlayerTwo") as? String
        
        // highlight players who turn it is
        switchPlayerLabelHighlight()
        
        // disable play and delete buttons until letter has been played
        deleteButton.enabled = false
        deleteButton.highlighted = true
        playButton.enabled = false
        playButton.highlighted = true
    }
    
    
    // saves game state as view if game hasnt ended
    // saves gameInProgress bool in defaults
    override func viewWillDisappear(animated: Bool)
    {
        saveGameState()

        defaults.setObject(gameInProgress, forKey: "gameInProgress")
        defaults.synchronize()
    }    
    
    
    // leave gameView, go to menu
    @IBAction func goToMenu(sender: UIButton)
    {
        defaults.setObject(gameInProgress, forKey: "gameInProgress")
        defaults.synchronize()
    }

    @IBAction func pressPlayButton(sender: UIButton)
    {
        // register that a game is being played
        self.gameInProgress = true
        
        // disable delete and play buttons
        deleteButton.enabled = false
        deleteButton.highlighted = true
        playButton.enabled = false
        playButton.highlighted = true

        // send content display to game class to filter dictionary
        currentGame.guess(lettersPlayedDisplay.text!)

        // check if gameOver check who won
        if currentGame.ended()
        {
            self.gameInProgress = false
            
            // check who won and save win
            playerWins()
        }
        
        // switch playerLabels to indicate who's turn
        currentGame.turn()
        switchPlayerLabelHighlight()
        
        // enables letter buttons so new letter can be played
        for button in alphaButtons
        {
            button.enabled = true
            button.highlighted = false
        }
    }
    
    
    // checks who won and saves the win in PlayerInfoManagement
    func playerWins()
    {
        currentGame.winner()
        if currentGame.playerOneWinner
        {
            managePlayerInfo.playerWins(playerOneLabel.text!)
            defaults.setValue(playerOneLabel.text, forKey: "winner")
        }
        else
        {
            managePlayerInfo.playerWins(playerTwoLabel.text!)
            defaults.setValue(playerTwoLabel.text, forKey: "winner")
        }
        
        // reset gameOver 
        currentGame.gameOver = false
        
        // goes to new view displaying the winner
        let winnerScene = self.storyboard?.instantiateViewControllerWithIdentifier("winnerScene") as! WinnerViewController
        self.navigationController?.pushViewController(winnerScene, animated: true)
        self.performSegueWithIdentifier("showWinner", sender: nil)
    }
    
    
    // delete button is pressed
    @IBAction func backSpaceButton(sender: UIButton)
    {
        // disable delete button
        deleteButton.enabled = false
        deleteButton.highlighted = true
        
        // deletes input in textfield when deleteButton is pressed
        let stringLength = count(lettersPlayedDisplay.text!)
        let substringIndex = stringLength - 1
        lettersPlayedDisplay.text = lettersPlayedDisplay.text!.substringToIndex(advance(lettersPlayedDisplay.text!.startIndex, substringIndex))
        
        // enables letter buttons when deletes 1 letter
        for button in alphaButtons
        {
            button.enabled = true
            button.highlighted = false
        }
    }
    
    
    // a letter button is pressed
    @IBAction func playedLetter(sender: UIButton)
    {
        // adds letter pressed to disply
        letter = sender.currentTitle!
        lettersPlayedDisplay.text = lettersPlayedDisplay.text! + letter
        
        // disables letter buttons when 1 letter pressed
        for button in alphaButtons
        {
            button.enabled = false
            button.highlighted = true
            
        }
        
        // enable delete & play button
        deleteButton.enabled = true
        deleteButton.highlighted = false
        playButton.enabled = true
        playButton.highlighted = false
    }
    
    
    // highlight player who's turn it is
    func switchPlayerLabelHighlight()
    {
        if currentGame.playerOneTurn
        {
            playerOneLabel.highlighted = true
            playerTwoLabel.highlighted = false
        }
        else if !currentGame.playerOneTurn
        {
            playerOneLabel.highlighted = false
            playerTwoLabel.highlighted = true
        }
    }
    
    
    // save data of current game in defaults 
    func saveGameState()
    {
        // playerOneTurn
        defaults.setObject(currentGame.playerOneTurn, forKey: "currentPlayerOneTurn")
        
        // filtered gamedictionary
        defaults.setObject(currentDictionary.filterDictionary, forKey: "currentFilterDictionary")
        
        // letters played
        defaults.setObject(lettersPlayedDisplay.text, forKey: "currentLettersPlayed")
        
        defaults.synchronize()
    }
}

