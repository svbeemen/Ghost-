//
//  ViewController.swift
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
let currentPlayers = Players()

class ViewController: UIViewController
{
    // UILabel player1
    @IBOutlet weak var playerOneLabel: UILabel!
    // UILabel player2
    @IBOutlet weak var playerTwoLabel: UILabel!
    // UILabel display lettersPlayed
    @IBOutlet weak var lettersPlayedDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
 
//    required init(coder aDecoder: NSCoder)
//    {
////        fatalError("init(coder:) has not been implemented")
//        playerOneLabel.highlighted = true
//    }
//   
    // playButton: is a function/action/method
    @IBAction func playButton(sender: UIButton)
    {
        playLookButton.enabled = false
        // load players names entered into labels.
        self.playerOneLabel.text = currentPlayers.namePlayerOne
        self.playerTwoLabel.text = currentPlayers.namePlayerTwo
        
        var win1: Int = currentPlayers.winsPlayerOne
        var win2: Int = currentPlayers.winsPlayerTwo
        
        println("win1 ")
        println(win1)
        println("win2 ")
        println(win2)
        
        // send content display to game class to filter dictionary
        currentGame.guess(lettersPlayedDisplay.text!)
        println("lettersPlayedDisplay! " + lettersPlayedDisplay.text!)
        
        // check if it is game over
        if currentGame.ended() 
        {
            println("game over")
            // checks who won and saves score
            currentGame.winner()
            println("check winner")
            if currentGame.playerOneWinner
            {
                currentPlayers.saveScorePlayerOne()
                println("player one wins!")
            }
            else
            {
                currentPlayers.saveScorePlayerTwo()
                println("player two wine!")
            }
            println("win1 ")
            println(win1)
            println("win2 ")
            println(win2)
            currentGame.gameDictionary.reset()
        }

        currentGame.turn()
        println(currentGame.turn())
        playerTurnHighlight(playerOneLabel, personTwo: playerTwoLabel)

    }
    
    func playerTurnHighlight(personOne: UILabel, personTwo: UILabel)
    {
        if playerOneLabel.highlighted == true
        {
            playerOneLabel.highlighted = false
            playerTwoLabel.highlighted = true
        }
        else
        {
            playerOneLabel.highlighted = true
            playerTwoLabel.highlighted = false
        }
    }
    @IBOutlet weak var playLookButton: UIButton!
//    func switch_player_label(player1: UILabel, player2: UILabel) {
//        let temp = player1.textColor
//        player1.textColor = player2.textColor
//        player2.textColor = temp
//    }
    
    // if letters in display does not == count lettersplayed + 1
    
    // letter buttons
    @IBAction func playedLetter(sender: UIButton)
    {
        // stores title of button pressed in variable
        let letter = sender.currentTitle!
        println(letter)
        
        playLookButton.enabled = true
        
        // adds letter button pressed to display
        lettersPlayedDisplay.text = lettersPlayedDisplay.text! + letter
        
        
        // when button pressed
        // title of button is letter played
        // disable all letter buttons
        // enable return and play button 
        // when play button is pressed enablen letterbuttons
        // when returnbutton is pressed enable letterbuttons
        
    }
    
    @IBAction func backSpaceButton(sender: UIButton)
    {
        // counts length of string in display and deletes last character
        if lettersPlayedDisplay.text != nil
        {
            let stringLength = count(lettersPlayedDisplay.text!)
            let substringIndex = stringLength - 1
            lettersPlayedDisplay.text = lettersPlayedDisplay.text!.substringToIndex(advance(lettersPlayedDisplay.text!.startIndex, substringIndex))
        }
    }
    
    // settings button => to settingsview/menu
    @IBAction func settingsButton(sender: UIButton)
    {
        let settingsView = self.storyboard?.instantiateViewControllerWithIdentifier("settingsView") as! ViewControllerSettings
        
        self.navigationController?.pushViewController(settingsView, animated: true)
    }



//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

