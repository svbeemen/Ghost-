//
//  PlayerClass.swift
//  wordGame
//
//  Created by Sangeeta van Beemen on 18/05/15 W21.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation

class Players
{
    var namePlayerOne: String
    var namePlayerTwo: String
    var winsPlayerOne: Int
    var winsPlayerTwo: Int
    
    init()
    {
        self.namePlayerOne = defaults.objectForKey("currentPlayerOne") as! String
        self.namePlayerTwo = defaults.objectForKey("currentPlayerTwo") as! String
    
        if playerScoresDic.objectForKey(self.namePlayerOne) == nil
        {
            playerScoresDic.setValue(0, forKey: self.namePlayerOne)
        }
     
        if playerScoresDic.objectForKey(self.namePlayerTwo) == nil
        {
            playerScoresDic.setValue(0, forKey: self.namePlayerTwo)
        }
        
        self.winsPlayerOne = playerScoresDic.valueForKey(self.namePlayerOne) as! Int
        self.winsPlayerTwo = playerScoresDic.valueForKey(self.namePlayerTwo) as! Int
    }
    
    func saveScorePlayerOne()
    {
        self.winsPlayerOne += 1
        defaults.setInteger(self.winsPlayerOne, forKey: self.namePlayerOne)
    }
    
    func saveScorePlayerTwo()
    {
        self.winsPlayerTwo += 1
        defaults.setInteger(self.winsPlayerTwo, forKey: self.namePlayerTwo)
    }
    
}