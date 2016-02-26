//
//  LoginViewController.swift
//  ThetaBooking
//
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
    
    
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.authenticateUser()
    }
    
    override func didReceiveMemoryWarning() {0
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        performSegueWithIdentifier("loginToNav", sender: self)
        
    }
    
    
    @IBAction func registerPressed(sender: UIButton) {
        performSegueWithIdentifier("loginToRegister", sender: self)
    }
    
    func authenticateUser() {
        var error: NSError?
        let reasonString = "Authentication is required"
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            [context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: {(success: Bool, policyError: NSError?) -> Void in
                
                // If the Touch ID check is correct
                if success {
                    print("Success")
                    //Load Data this way
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
                    //self.showRegistration()
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
            //self.showRegistration()
        }
    }
    
    func showRegistration() {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("registration")
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(vc!, animated: true, completion: nil)
        })
    }
    
}

