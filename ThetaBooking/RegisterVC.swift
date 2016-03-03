//
//  RegisterVC.swift
//  ThetaBooking
//
//  Created by Matthew Copson on 16/02/2016.
//  Copyright © 2016 Genesis. All rights reserved.
//

import Foundation
import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    
    func alert(message:String) {
        let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action:UIAlertAction = UIAlertAction(title: "Okay I'm Sorry", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    //created the IB Outlets for reference
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var passwordConfirmTextField: UITextField!
    
    
    
    @IBAction func cancelPressed(sender: AnyObject) {
        
       performSegueWithIdentifier("registerToLogin", sender: self)
         alert("Please make sure that your passwords are matching")
    }
    
    @IBAction func registerPressed(sender: AnyObject) {
        
        if passwordTextField.text != passwordConfirmTextField.text{
            self.alert("passwords not matching")
        }
        
        if nameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" || passwordConfirmTextField.text == "" {
            print("hello")
            print(nameTextField.text)
            var text:[String] = []
            
            if nameTextField.text == "" {
                text.append("name")
            }
            if emailTextField.text == "" {
                text.append("email")
                
            }
            if passwordTextField.text == ""{
                text.append("password")
            }
            if passwordConfirmTextField.text == ""{
                text.append("password confirmation")
                
            }
            
        if text.count == 1 {
              self.alert("Missing fields: \(text[0])")
         }
        else if text.count > 1{
            var mystring:String = ""
            for item in text {
                mystring += item + ", "
            }
            //mystring.removeAtIndex(mystring.endIndex)
            //mystring.removeAtIndex(mystring.endIndex)
            self.alert("Missing fields: " + mystring)
            }
            
            
            return
        }
        
        guard emailTextField.text?.containsString("@") == true else {
            self.alert("Email not valid")
            return
        }
        guard emailTextField.text?.containsString(".") == true else {
            self.alert("Email not valid")
            return
        }
        
        

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