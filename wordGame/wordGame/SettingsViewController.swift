//
//  ViewControllerSettings.swift
//  wordGame
//
//  Created by Sangeeta van Beemen on 17/05/15 W20.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

//var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

class SettingsViewController: UIViewController
{
    // language setting segmnet control. save language seting in NSUerDefaults Class
    @IBOutlet weak var languageSettingSegmentControl: UISegmentedControl!
    
    // resume game that was in progress button
    @IBOutlet weak var resumeGameButton: UIButton!
    
    // bool to indicate to show and reload game that was being played
    var gameInProgress: Bool!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
//        // determines wether to show and enable resume game button 
//        self.gameInProgress = defaults.boolForKey("gameInProgress")
//        
//        if (self.gameInProgress != nil)
//        {
//            resumeGameButton.hidden = false
//            resumeGameButton.enabled = true
//        }
    }
    
    // back to menu button from settings view when changed nothing
    @IBAction func backToGameButton(sender: UIButton)
    {
        // self.navigationController?.popToViewController(gameScene, animated: true)
    }


    @IBAction func changeLanguageSegmentControl(sender: UISegmentedControl)
    {
        let savedLanguage = languageSettingSegmentControl.selectedSegmentIndex
        
        switch (languageSettingSegmentControl.selectedSegmentIndex)
        {
        case 0:
            defaults.setValue("english", forKey: "language")
        case 1:
            defaults.setValue("dutch", forKey: "language")
        default:
            defaults.setValue("english", forKey: "language")
        }
    }
    
    // new game button. reset dictionary and game when pressed
    // go back to initial enter info player view
    @IBAction func newGameButton(sender: UIButton)
    {
        
    }
    
    // topscore button. go to view with table view of topscores saved in NSuserDefaults.
    @IBAction func topScoreButton(sender: UIButton)
    {
        let highscoreScene = self.storyboard?.instantiateViewControllerWithIdentifier("highscoreScene") as! HighScoresViewViewController
        self.navigationController?.pushViewController(highscoreScene, animated: true)

    }

    

//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */

}
