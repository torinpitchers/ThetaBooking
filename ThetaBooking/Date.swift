//
//  Date.swift
//  ThetaBooking
//
//  Created by Harry Moy on 02/02/2016.
//  Copyright © 2016 Harry Moy. All rights reserved.
//

import Foundation

extension NSDate {
    func makeStringFromDate(date:NSDate) -> String {
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        formatter.timeStyle = .MediumStyle
        let formattedString = formatter.stringFromDate(date)
        return formattedString
    }
}