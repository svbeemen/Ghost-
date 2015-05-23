//
//  HighScoresViewController.swift
//  Ghost
//
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//
//  naam: Sangeeta van Beemen
//  studentnummer: 10340521
//

import UIKit

class HighScoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // go back to menu screen
    @IBAction func backToMenu(sender: UIButton)
    {
    }
    
    // tableview to hold highscores
    @IBOutlet weak var highScoreTableView: UITableView!
    
    // instance which accesses all saved playerInfo
    var highscoreModel: PlayerInfoManagement = PlayerInfoManagement()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // tableview delegate and datasorce
        highScoreTableView.delegate = self
        highScoreTableView.dataSource = self
        self.highScoreTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    // tableview protocols
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.highscoreModel.highScoreViewList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = self.highScoreTableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        // indexes through highscore list. displays name and wins 
        var player = self.highscoreModel.highScoreViewList[indexPath.row]
        var score = self.highscoreModel.highscores[player]!
        
        cell.textLabel?.text = "\(indexPath.row + 1). \(player)  \(score)"
        
        return cell
    }
}
