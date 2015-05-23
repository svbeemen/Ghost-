//
//  PlayerInfoManagement.swift
//  Ghost
//
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//
//  naam: Sangeeta van Beemen
//  studentnummer: 10340521
//

import Foundation

class PlayerInfoManagement
{
    // NSUserDefaults singelton
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    // list of player names for namepickers
    var playerNames = [String]()
    
    // list of playerNames and scores
    var highscores: [String: Int]
    
    // list of playerNames and scores for highscore view
    var highScoreViewList = [String]()
    
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
        
        // retrieve players list form defaults
        if let playerNames = defaults.objectForKey("playerNames") as? [String]
        {
            self.playerNames = playerNames
        }
        else
        {
            self.playerNames = [String]()
        }
        
        // sort highscores and assign content to list for highscoreView
        sortHighscoresList()
    }
    
    // sort highscores and assign content to list for highscoreView
    func sortHighscoresList()
    {
        highScoreViewList = sorted(highscores.keys, {player1, player2 in self.highscores[player1] > self.highscores[player2]})
        savePlayersInfo()
    }
    
    
    // adds player if newplayer to highscores & playerNames
    func addPlayer(playerName: String)
    {
        // check if player is already in highscore list
        if highscores[playerName] != nil
        {
            return
        }
        else
        {
            highscores[playerName] = 0
            playerNames.append(playerName)
        }

        savePlayersInfo()
    }
    
    
    // increments wins of input player by 1
    func playerWins(playerName: String)
    {
        highscores[playerName]? += 1
        sortHighscoresList()
        savePlayersInfo()
    }
    
    
    // saves all players info in defaults
    func savePlayersInfo()
    {
        defaults.setObject(playerNames, forKey: "playerNames")
        defaults.setObject(highscores, forKey: "highscores")
        defaults.synchronize()
    }

}



    
