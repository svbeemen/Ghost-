//
//  gameClass .swift
//  Ghost
//
//  Created by Sangeeta van Beemen on 20/04/15 W18.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation

class Game
{
    var gameDictionary : Dictionary
    var lettersPlayed : String
    var playerOneTurn : Bool
    var endOfGame : Bool
    
    init(gameDictionary : Dictionary)
    {
        self.gameDictionary = gameDictionary
        self.lettersPlayed = ""
        self.playerOneTurn = true
        self.endOfGame = false
    }
    
    func guess(letterInput:String)
    {
        self.lettersPlayed += letterInput
        gameDictionary.filter(letterInput)
    }
    
    func turn() -> Bool
    {
        self.playerOneTurn = !self.playerOneTurn
        return self.playerOneTurn
    }
    
    func ended() -> Bool
    {
        
        if self.gameDictionary.checkWordList.count == 0 || countElements(self.lettersPlayed) > 3 &&  contains(gameDictionary.checkWordList, self.lettersPlayed)
        {
            self.endOfGame == true
        }
        return self.endOfGame
    }
    
    func winner() -> Bool
    {
        return !self.turn()
    }

}
