//
//  GameClass.swift
//  Ghost
//
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//
//  naam: Sangeeta van Beemen
//  studentnummer: 10340521
//

import Foundation

class Game
{
    // instance of Dictionary to acces Dictionary methods
    var gameDictionary: Dictionary
    
    // bool to indicate players turn
    var playerOneTurn: Bool
    
    // bool to indicate if game has ended
    var gameOver: Bool
    
    // bool to indicate the winner
    var playerOneWinner: Bool
    
    // the letters the players have played 
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
        self.playerOneTurn = !self.playerOneTurn
        return self.playerOneTurn
    }

    
    // checks if letters played is valid
    func ended() -> Bool
    {
        if (count(self.lettersPlayed) > 3 && contains(gameDictionary.filterDictionary, self.lettersPlayed)) || (gameDictionary.count() == 0)
        {
            gameOver = true
        }
        
        return gameOver
    }

    
    // the player who didnt trigger gameOver wins
    func winner() -> Bool
    {
        if !self.playerOneTurn
        {
            self.playerOneWinner = true
        }
        return self.playerOneWinner
    }
}

