//
//  PlayerViewController.swift
//  wordGame
//
//  Created by Sangeeta van Beemen on 18/05/15 W21.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

class PlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate
{
    // textfield player1
    @IBOutlet weak var playerOneTextFieldInput: UITextField!
    
    // textfield player2
    @IBOutlet weak var playerTwoTextFieldInput: UITextField!
    
    // namePicker player1
    @IBOutlet weak var playerOneNamePicker: UIPickerView!
    
    // namePicker player2
    @IBOutlet weak var playerTwoNamePicker: UIPickerView!
    
    // pickName Buttons
    @IBOutlet weak var pickNamePlayer1Button: UIButton!
    
    @IBOutlet weak var pickNamePlayer2Button: UIButton!

    // startGame Button
    @IBOutlet weak var startGameButton: UIButton!
    
    // contents of name pickers
    var playerNamesPickerOne: [String]
    var playerNamesPickerTwo: [String]

    required init(coder aDecoder: NSCoder)
    {

        // retrieve playerNames from defaults
        println(defaults.objectForKey("playerNames"))
        
        if let playerNamesPickerOne = defaults.objectForKey("playerNames") as? [String]
        {
            self.playerNamesPickerOne = playerNamesPickerOne
            let playerNamesPickerTwo = defaults.objectForKey("playerNames") as? [String]
            self.playerNamesPickerTwo = playerNamesPickerTwo!
        }
        // if no previous players picker empty
        else
        {
            self.playerNamesPickerOne = [String]()
            self.playerNamesPickerTwo = [String]()
        }
        
        super.init(coder: aDecoder)
        
    }
    
    // assign delegates and data for textfields and pickers
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.playerOneNamePicker.dataSource = self
        self.playerTwoNamePicker.dataSource = self
        
        self.playerOneNamePicker.delegate = self
        self.playerTwoNamePicker.delegate = self
        
        self.playerOneNamePicker.hidden = true
        self.playerTwoNamePicker.hidden = true
        
        self.playerOneNamePicker.reloadAllComponents()
        self.playerTwoNamePicker.reloadAllComponents()
        
        self.playerOneTextFieldInput.delegate = self
        self.playerTwoTextFieldInput.delegate = self
    }
    
    
    // hide keyboard when done is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return true
    }
    
    
    // show or hide namePicker player1 when pressed
    @IBAction func showNamePickerOneButton(sender: AnyObject)
    {
        self.playerOneNamePicker.hidden = !self.playerOneNamePicker.hidden

        println(self.playerOneNamePicker.hidden)
    }

    
    // show or hide namePicker player2 when pressed
    @IBAction func showNamePickerTwoButton(sender: UIButton)
    {
        self.playerTwoNamePicker.hidden = !self.playerTwoNamePicker.hidden
        
        println(self.playerTwoNamePicker.hidden)
    }
    

    // to display excisting playerNames in namePickers
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }

    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return playerNamesPickerOne.count + playerNamesPickerTwo.count
    }
    

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return playerNamesPickerOne[row] + playerNamesPickerTwo[row]
    }
    
    
    // sets name selected in name picker in textfield
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == playerOneNamePicker
        {
            playerOneTextFieldInput.text = playerNamesPickerOne[row]
        }
        else if pickerView == playerTwoNamePicker
        {
            playerTwoTextFieldInput.text = playerNamesPickerTwo[row]
        }
    }
    
    
    // start game button
    @IBAction func startGameButton(sender: UIButton)
    {
        // save names of current players in defaults
        defaults.setObject(playerOneTextFieldInput.text!, forKey: "currentPlayerOne")
        defaults.setObject(playerTwoTextFieldInput.text!, forKey: "currentPlayerTwo")
        
        // instance of to manage current players info
        var playerInfoManagement: PlayerInfoManagement = PlayerInfoManagement()
        
        // set info of current players
        playerInfoManagement.setScoreNewPlayer(playerOneTextFieldInput.text!)
        playerInfoManagement.setScoreNewPlayer(playerTwoTextFieldInput.text!)
        playerInfoManagement.saveHighscoresList()
        
        // save current playerNames in playerNamesList in defaults
        playerInfoManagement.playerNames.append(playerOneTextFieldInput.text!)
        playerInfoManagement.playerNames.append(playerTwoTextFieldInput.text!)
        defaults.setObject(playerInfoManagement.playerNames, forKey: "playerNames")
        
        // instantiate a gameScene when startGameButton is pressed
        let gameScene = self.storyboard?.instantiateViewControllerWithIdentifier("gameScene") as! GameViewController
        self.navigationController?.pushViewController(gameScene, animated: true)
    }
    
    //settings button
    @IBAction func settingsButton(sender: UIButton)
    {
        let settingsView = self.storyboard?.instantiateViewControllerWithIdentifier("settingsView") as! SettingsViewController
        
        self.navigationController?.pushViewController(settingsView, animated: true)
    }
}

    

    
    

