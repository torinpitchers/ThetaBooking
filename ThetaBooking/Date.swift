//
//  Date.swift
//  ThetaBooking
//
//  Created by Harry Moy on 02/02/2016.
//  Copyright © 2016 Harry Moy. All rights reserved.
//

import Foundation

extension NSDate {
    func makeStringForDate(date:NSDate) -> String {
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .NoStyle
        let formattedString = formatter.stringFromDate(date)
        return formattedString
    }
    func makeStringForTime(date:NSDate) -> String {
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = .NoStyle
        formatter.timeStyle = .ShortStyle
        let formattedString = formatter.stringFromDate(date)
        return formattedString
    }

}