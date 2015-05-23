//
//  SettingsViewController.swift
//  Ghost
//
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//
//  naam: Sangeeta van Beemen 
//  studentnummer: 10340521
//

import UIKit

class SettingsViewController: UIViewController
{
    // language setting segmnet control
    @IBOutlet weak var languageSettingSegmentControl: UISegmentedControl!
    
    // resume gameButton
    @IBOutlet weak var resumeGameButton: UIButton!
    
    // bool to indicate if there was a game in session
    let gameInProgress: Bool

    // retrieve value of bool gameInProgress from defaults
    required init(coder aDecoder: NSCoder)
    {
        if let gameInProgress = defaults.objectForKey("gameInProgress") as? Bool
        {
            self.gameInProgress = gameInProgress
        }
        else
        {
            self.gameInProgress = false
        }
        super.init(coder: aDecoder)
    }
    
    
    // if game was in progress enable and show resumeGameButton
    override func viewWillAppear(animated: Bool)
    {
        if self.gameInProgress
        {
            resumeGameButton.enabled = true
            resumeGameButton.hidden = false
        }
        else 
        {
            resumeGameButton.enabled = false
            resumeGameButton.hidden = true
        }
    }
    
    
    // save language selected in defaults
    @IBAction func changeLanguageSegmentControl(sender: UISegmentedControl)
    {
        switch (languageSettingSegmentControl.selectedSegmentIndex)
        {
        case 0:
            defaults.setValue("english", forKey: "language")
        case 1:
            defaults.setValue("dutch", forKey: "language")
        default:
            defaults.setValue("english", forKey: "language")
        }
        
        // when language changed resume button is hidden and disabled
        resumeGameButton.enabled = false
        resumeGameButton.hidden = true
        
        defaults.synchronize()
    }
    
    
    // go to Highscores view
    @IBAction func viewHighScores(sender: UIButton)
    {
    }
    
    
    // save language set in defaults
    func saveLanguage()
    {
        if languageSettingSegmentControl.selectedSegmentIndex == 0
        {
            defaults.setValue("english", forKey: "language")
        }
        else
        {
            defaults.setValue("dutch", forKey: "language")
        }
    }
    
    
    // start new game
    @IBAction func newGameButton(sender: UIButton)
    {
        // set language in defaults for dictionary 
        saveLanguage()  
        // resets game to initial state if game was lefted before gameover
        let gameInProgress = false
        defaults.setObject(gameInProgress, forKey: "gameInProgress")
        defaults.synchronize()
    }
}
