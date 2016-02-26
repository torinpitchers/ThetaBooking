//
//  NextBookingVC.swift
//  ThetaBooking
//
//  Created by Matthew Copson on 10/02/2016.
//  Copyright © 2016 Harry Moy. All rights reserved.
//

import Foundation
import UIKit


class NextBookingVC : UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var rebookButton: UIButton!
    
    @IBAction func Rebook(sender: AnyObject) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rebookButton.hidden = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respond:")
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respond:")
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        
        profileImageView.image = UIImage(named: "profileImage")
        
    }
    
    func respond(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.Right:
                nameLabel.text = "right"
                dateLabel.text = "wed 30th Sep 2009"
                timeLabel.text = "11:00am"
                rebookButton.hidden = false
            case UISwipeGestureRecognizerDirection.Left:
            nameLabel.text = "Left"
            dateLabel.text = "sunday 14th February"
            timeLabel.text = "12:00am"
            rebookButton.hidden = true
            default:
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}