//
//  GameClass.swift
//  wordGame
//
//  Created by Sangeeta van Beemen on 16/05/15 W20.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation

class Game
{
    var gameDictionary: Dictionary
    var playerOneTurn: Bool
    var gameOver: Bool
    var playerOneWinner: Bool
    var lettersPlayed: String
    
    init(gameDictionary: Dictionary)
    {
        self.gameDictionary = gameDictionary
        self.playerOneTurn = true
        self.lettersPlayed = ""
        self.gameOver = false
        self.playerOneWinner = false
    }
    
    // gets input form gameViewController and use dictionary instance to filter gameDictionary 
    func guess(newLetter: String)
    {
        self.lettersPlayed = newLetter
//        println(self.lettersPlayed + " self.lettersPlayed")
//        println("game guess function")
        self.gameDictionary.filter(lettersPlayed)
    }
    
    // sets playerOneTurn from true to false and vice versa
    func turn() -> Bool
    {
        self.playerOneTurn = !self.playerOneTurn
        defaults.setBool(self.playerOneTurn, forKey: "currentPlayerOneTurn")
        return self.playerOneTurn
    }

    
    func ended() -> Bool
    {
        if count(self.lettersPlayed) > 3 && contains(gameDictionary.filterDictionary, self.lettersPlayed) || gameDictionary.count() == 0
        {
            gameOver = true
            println(gameOver)
        }
        defaults.setBool(self.gameOver, forKey: "currentGameOver")
//        defaults.setValue(self.filterDictionary, forKey: "filterDictionary")
        return gameOver
    }


    
    // determines who won. the players who's turn it is not is the winner. He did not trigger gameOver 
    func winner() -> Bool
    {
        if self.playerOneTurn == false
        {
            self.playerOneWinner = true
        }
        
        defaults.setBool(self.playerOneWinner, forKey: "currentPlayerOneWinner")
        return self.playerOneWinner
    }
}

