//
//  WinnerViewController.swift
//  Ghost
//
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//
//  naam: Sangeeta van Beemen
//  studentnummer: 10340521
//

import UIKit

class WinnerViewController: UIViewController {
    
    // label for winner message
    @IBOutlet weak var winnerLabel: UILabel!
    
    // button to go to menu
    @IBAction func goToMenu(sender: UIButton)
    {
    }
    
    // winner of game
    let winner: String
    
    // retrieve name of winner from defaults
    required init(coder aDecoder: NSCoder)
    {
        self.winner = defaults.valueForKey("winner") as! String
        
        super.init(coder: aDecoder)
    }
    
    // show name of winner and message
    override func viewWillAppear(animated: Bool)
    {
        winnerLabel.text = "Congratualations \(self.winner)!"
    }
}
