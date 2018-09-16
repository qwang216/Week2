//
//  Extensions.swift
//  Week2
//
//  Created by Jason wang on 9/14/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

extension UIColor {
    static func circularLoaderStrokeColor() -> UIColor {
        return UIColor.red(91, green: 47, blue: 214)
    }


    static func red(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255 , green: green / 255, blue: blue / 255, alpha: 1)
    }

}
