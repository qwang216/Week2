//
//  Category.swift
//  Week2
//
//  Created by Jason wang on 9/14/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

struct Category {
    let name: String
    let min: TimeInterval
    let max: TimeInterval
    var mid: TimeInterval {
        return (min + max) / 2
    }

}
