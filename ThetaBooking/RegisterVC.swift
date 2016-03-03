//
//  RegisterVC.swift
//  ThetaBooking
//
//  Created by Matthew Copson on 16/02/2016.
//  Copyright © 2016 Genesis. All rights reserved.
//

import Foundation
import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate {
    
    //created the IB Outlets for reference
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func cancelPressed(sender: AnyObject) {
        
       performSegueWithIdentifier("registerToLogin", sender: self)
        
    }
    
    //initialising the delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //if the user hits return on the keypad then the keyboard disappears
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //if the user touches anywhere on the view, the keyboard disappears
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}