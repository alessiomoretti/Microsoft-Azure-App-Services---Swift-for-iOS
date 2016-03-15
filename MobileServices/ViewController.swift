//
//  ViewController.swift
//  MobileServices
//
//  Created by Odysseus on 07/03/16.
//  Copyright © 2016 MSPRoma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var infoLabel:     UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adding (single or multiple) tap listener to close keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    
    // IBAction on the button to send data to Azure Mobile Services
    @IBAction func sendDataToAzure(sender: UIButton) {
        
        // hiding keyboard after hitting button
        dismissKeyboard()
        
        // updating UI info label
        infoLabel.text = "Sending data..."
        // connecting to Azure Mobile Services
        let client = MSClient(
            applicationURLString: "https://mobileprova.azurewebsites.net"
        )
        let item = ["text":(dataTextField.text)!]
        let itemTable = client.tableWithName("TodoItem")
        itemTable.insert(item) {
            (insertedItem, error) in
            if (error != nil) {
                // printing out error status to UI
                self.infoLabel.text = "Error sending data"
                self.infoLabel.textColor = UIColor.redColor()
                // printing out error status to diagnostic log
                print("Error" + error!.description)
            } else {
                // printing out success status to UI
                self.infoLabel.text = "Success!"
                self.infoLabel.textColor = UIColor.greenColor()
                // printing out success status to diagnostic log
                print("Item inserted: " + (insertedItem?.description)!)
            }
        }
        
        // resetting the label color
        self.infoLabel.textColor = UIColor.blackColor()
    }
    
    // dismissing keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

