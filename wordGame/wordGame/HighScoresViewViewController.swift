//
//  HighScoresViewViewController.swift
//  wordGame
//
//  Created by Sangeeta van Beemen on 22/05/15 W21.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class HighScoresViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var highscoreModel: PlayerInfoManagement = PlayerInfoManagement()
    
    @IBOutlet weak var highScoreTableView: UITableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        highScoreTableView.delegate = self
        highScoreTableView.dataSource = self
        self.highScoreTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.highscoreModel.playerNames.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = self.highScoreTableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        var player = self.highscoreModel.playerNames[indexPath.row]
        var score = self.highscoreModel.highscores[player]!
        
        cell.textLabel?.text = "\(indexPath.row + 1). \(player): \(score)"
        
        return cell
    }
}
