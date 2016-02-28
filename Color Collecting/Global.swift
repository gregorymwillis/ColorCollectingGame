//
//  Global.swift
//  Color Collecting
//
//  Created by Greg Willis on 2/28/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit

/**
 Gets you a random number (CGFloat) between 0 and 1.
 - Returns: A pseudo-random number between 0 and 1.
 */
func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
}

struct ColorProvider {
    static let offWhiteColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
    static let offBlackColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    static let grayBlueColor = UIColor(red: (60/255), green: (100/255), blue: (160/255), alpha: 1.0)
}
