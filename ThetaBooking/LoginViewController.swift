//  LoginViewController.swift
//  ThetaBooking
//  Created by Harry Moy on 18/01/2016.
//  Copyright © 2016 Genesis. All rights reserved.


import UIKit
import LocalAuthentication

enum LAError : Int {
    case AuthenticationFailed
    case UserCancel
    case UserFallback
    case SystemCancel
    case PasscodeNotSet
    case TouchIDNotAvailable
    case TouchIDNotEnrolled
}

class LoginViewController: UIViewController {
    
    let context:LAContext = LAContext()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let MyKeychainWrapper = KeychainWrapper()
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        userAlreadyExist()
    }
    
    
    override func didReceiveMemoryWarning() {0
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func alert(message:String) {
        let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action:UIAlertAction = UIAlertAction(title: "Okay I'm Sorry", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

   
    // the complete login function
    @IBAction func login(sender: AnyObject) {
        
        if (usernameField.text == "" || passwordField.text == "") {
            let alertView = UIAlertController(title: "Login Problem",
                message: "Please enter username and password." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }
        
        
        
        if sender.tag == createLoginButtonTag {
            
            
            
           
            do {
                let success = try APICall.authenticate(usernameField.text!, password: passwordField.text!)
                
                if success == true {
                    print("got here")
                    
                    
                    let hasLoginKey = self.defaults.boolForKey("hasLoginKey")
                    if hasLoginKey == false {
                        self.defaults.setValue(self.usernameField.text, forKey: "username")
                    }
                    
                    self.defaults.setValue(self.usernameField.text, forKey: "username")
                    MyKeychainWrapper.mySetObject(passwordField.text, forKey:kSecValueData)
                    MyKeychainWrapper.writeToKeychain()
                    self.defaults.setBool(true, forKey: "hasLoginKey")
                    self.defaults.synchronize()
                    loginButton.tag = loginButtonTag
                    
                    
                    performSegueWithIdentifier("loginToNav", sender: self)
                }
                else {
                    self.alert("Login Failed - Invalid Username or Password")
                    
                }
            } catch {
                print("Error making API call")
            }
            
            
            
        
        } else if sender.tag == loginButtonTag {
            if checkLogin(usernameField.text!, password: passwordField.text!) {
                
                do {
                    let success = try APICall.authenticate(usernameField.text!, password: passwordField.text!)
                    
                    if success == true {
                        performSegueWithIdentifier("loginToNav", sender: self)
                    }
                } catch {
                    print("Error making API call")
                }
            } else {
                print("not equal to NSUserDefaults")
            }
        }
    }
    
    
    //if the user hits return on the keypad then the keyboard disappears
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }
    
    //if the user touches anywhere on the view, the keyboard disappears
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //if user clicks "create an account" the segue is performed
    @IBAction func registerPressed(sender: UIButton) {
        performSegueWithIdentifier("loginToRegister", sender: self)
    }
    
    func checkLogin(username: String, password: String ) -> Bool {
            if password == MyKeychainWrapper.myObjectForKey("v_Data") as? String &&
                username == self.defaults.valueForKey("username") as? String {
                    return true
            } else {
                return false
            }
        }
    
    func userAlreadyExist() {
        let hasAccount = self.defaults.boolForKey("hasLoginKey")
        
        if hasAccount {
            print("test")
            self.authenticateUser()
        }
        else {
            print("nope")
            //showRegistration()
        }
        
    }
    
    func authenticateUser() {
        var error: NSError?
        let reasonString = "Authentication is required"
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            [context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: {(success: Bool, policyError: NSError?) -> Void in
                
                // If the Touch ID check is correct
                if success {
                    let retrieveKeyChain: String = self.MyKeychainWrapper.myObjectForKey("v_Data") as! String
                    let retrieveUsername: String = self.defaults.objectForKey("username") as! String
                    self.usernameField.text = retrieveUsername
                    self.passwordField.text = retrieveKeyChain
                    
                }
                    // Displays which error has occurred in the console
                else {
                    switch policyError!.code {
                    case LAError.SystemCancel.rawValue:
                        print("System cancelled authentication")
                    case LAError.UserCancel.rawValue:
                        print("User cancelled authentication")
                    case LAError.UserFallback.rawValue:
                        print("User has decided to enter customer password")
                        //view to open user password goes here
                    default:
                        print("Error doing it")
                    }
                
                }
            })]
        }
            
        else {
            switch error?.code {
            case LAError.TouchIDNotEnrolled.rawValue?:
                print("Touch ID not enrolled")
            case LAError.PasscodeNotSet.rawValue?:
                print("No passcode set")
            default:
                print("There's some reason for it not working")
            }
        
        }
    }
    
    func showRegistration() {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("registration")
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(vc!, animated: true, completion: nil)
        })
    }
    
}

