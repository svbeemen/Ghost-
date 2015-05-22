//
//  PlayerInfoManagement.swift
//  wordGame
//
//  Created by Sangeeta van Beemen on 22/05/15 W21.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation

class PlayerInfoManagement
{
    
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var playerNames = [String]()
    var highscores: [String: Int]
    
    init()
    {
        // retrieve highscore list from defaults
        if let highscores = defaults.objectForKey("highscores") as? [String: Int]
        {
            self.highscores = highscores
        }
        else
        {
            self.highscores = [String:Int]()
        }
    }
    
    
    func setScoreNewPlayer(playerName: String)
    {
        // check if player is already in highscore list
        if highscores[playerName] != nil
        {
            return
        }
        else
        {
            highscores[playerName] = 0
        }
    }
    
    
    func playerWins(playerName: String)
    {
        highscores[playerName]? += 1
        sortHighscoresList()
        saveHighscoresList()
    }
    
    
    func sortHighscoresList()
    {
        playerNames = sorted(highscores.keys, {player1, player2 in self.highscores[player1] > self.highscores[player2]})

    }
    
    
    func saveHighscoresList()
    {
        defaults.setObject(highscores, forKey: "highscores")
        defaults.synchronize()
    }

    
}