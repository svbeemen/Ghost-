//
//  PlayerViewController.swift
//  wordGame
//
//  Created by Sangeeta van Beemen on 18/05/15 W21.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit
var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
var playerScoresDic: NSMutableDictionary = NSMutableDictionary()

class PlayerViewController: UIViewController {

    // textfield player1
    @IBOutlet weak var playerOneTextFieldInput: UITextField!
    
    // textfield player2
    @IBOutlet weak var playerTwoTextFieldInput: UITextField!
    
    //settings button
    @IBAction func settingsButton(sender: UIButton)
    {
        let settingsView = self.storyboard?.instantiateViewControllerWithIdentifier("settingsView") as! ViewControllerSettings
        
        self.navigationController?.pushViewController(settingsView, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // start game button
    @IBAction func startGameButton(sender: UIButton)
    {
        // save input textfields in variable with name: namePlayerOne & namePlayerTwo. value stores is input of textfields.
        defaults.setObject(playerOneTextFieldInput.text!, forKey: "currentPlayerOne")
        defaults.setObject(playerTwoTextFieldInput.text!, forKey: "currentPlayerTwo")
        
        var playerScoresDic: NSMutableDictionary = NSMutableDictionary()
        // instantiate a gameScene when startGameButton is pressed
        let gameScene = self.storyboard?.instantiateViewControllerWithIdentifier("gameScene") as! ViewController
        self.navigationController?.pushViewController(gameScene, animated: true)
    }
//
//    @IBAction func loadDataClicked(sender: AnyObject) {
//        
//        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
//        
//        if let firstNameIsNotNill = defaults.objectForKey("firstName") as? String {
//            self.firstNameTextField.text = defaults.objectForKey("firstName") as String
//        }
//        
//        if let lastNameIsNotNill = defaults.objectForKey("lastName") as? String {
//            self.lastNameTextField.text = defaults.objectForKey("lastName") as String
//        }
//        
//        if let emailIsNotNill = defaults.objectForKey("email") as? String {
//            self.emailTextField.text = defaults.objectForKey("email") as String
//        }
//        
//        if let phoneNumberIsNotNill = defaults.objectForKey("phoneNumber") as? String {
//            self.phoneNumberTextField.text = defaults.objectForKey("phoneNumber") as String
//        }
//        
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
