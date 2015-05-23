//
//  PlayerViewController.swift
//  Ghost
//
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//
//  naam: Sangeeta van Beemen
//  studentnummer: 10340521
//

import UIKit

// variable to access NSUserDeafults
var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

// to handle input playersNames and display previous player names
var managePlayerInfo: PlayerInfoManagement = PlayerInfoManagement()


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
    let savedPlayerNames: [String]


    required init(coder aDecoder: NSCoder)
    {
        // retrieve playerNames from defaults through managementPlayerInfo class
        self.savedPlayerNames = managePlayerInfo.playerNames

        super.init(coder: aDecoder)
    }
    
    
    // assign delegates and datasource for textfields and pickers
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
    
    // disable start button till players enter names
    override func viewWillAppear(animated: Bool)
    {
        startGameButton.enabled = false
    }
    
    
    // show and hide namePicker player1 when pressed
    @IBAction func showNamePickerOneButton(sender: AnyObject)
    {
        self.playerOneNamePicker.hidden = !self.playerOneNamePicker.hidden
    }

    
    // show and hide namePicker player2 when pressed
    @IBAction func showNamePickerTwoButton(sender: UIButton)
    {
        self.playerTwoNamePicker.hidden = !self.playerTwoNamePicker.hidden
    }
    
    
    // startGame go to gameView
    @IBAction func pressStartGameButton(sender: UIButton)
    {
        // save names of current players in defaults
        defaults.setObject(playerOneTextFieldInput.text!, forKey: "currentPlayerOne")
        defaults.setObject(playerTwoTextFieldInput.text!, forKey: "currentPlayerTwo")
        
        // instance of to manage current players info
        managePlayerInfo.addPlayer(playerOneTextFieldInput.text!)
        managePlayerInfo.addPlayer(playerTwoTextFieldInput.text!)
    }
    
    
    // hide keyboard when done is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        // checks if both players entered a name
        checkForInputPlayerName()
        
        self.view.endEditing(true)
        return true
    }
    
    
    // pickerView protocols to show playerNames
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return savedPlayerNames.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return savedPlayerNames[row]
    }
    
    
    // sets name selected in name picker in textfield
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == playerOneNamePicker
        {
            playerOneTextFieldInput.text = savedPlayerNames[row]
        }
        else if pickerView == playerTwoNamePicker
        {
            playerTwoTextFieldInput.text = savedPlayerNames[row]
        }
        
        // checks if both players entered a name
        checkForInputPlayerName()
    }
    
    
    // enables startButton when both players have entered a name
    func checkForInputPlayerName()
    {
        if !playerTwoTextFieldInput.text.isEmpty && !playerOneTextFieldInput.text.isEmpty
        {
            startGameButton.enabled = true
        }
        
        if playerTwoTextFieldInput.text.isEmpty || playerOneTextFieldInput.text.isEmpty
        {
            startGameButton.enabled = false
        }
    }
    
    
    // checks if both players enterd a name  
    func textFieldDidEndEditing(textField: UITextField)
    {
        checkForInputPlayerName()
    }
}

    

    
    

