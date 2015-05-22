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
        self.gameDictionary.filter(lettersPlayed)
    }
    
    
    // sets playerOneTurn from true to false and vice versa
    func turn() -> Bool
    {
        println("in func before")
        println(self.playerOneTurn)
        self.playerOneTurn = !self.playerOneTurn
        println("in func after")
        println(self.playerOneTurn)
        return self.playerOneTurn
    }

    // checks if somebody lost
    func ended() -> Bool
    {
        if (count(self.lettersPlayed) > 3 && contains(gameDictionary.filterDictionary, self.lettersPlayed)) || (gameDictionary.count() == 0)
        {
            gameOver = true
            println(gameOver)
        }
        
        return gameOver
    }

    
    // determines who won. the players who's turn it is not is the winner. He did not trigger gameOver 
    func winner() -> Bool
    {
        if !self.playerOneTurn
        {
            self.playerOneWinner = true
        }
        return self.playerOneWinner
    }
}

