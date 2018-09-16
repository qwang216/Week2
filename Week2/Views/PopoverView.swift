//
//  PopoverView.swift
//  Week2
//
//  Created by Jason wang on 9/16/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class PopoverView: UIView {
    @IBOutlet weak var categoryTableView: UITableView!

    static func instantiateViewFromxib() -> PopoverView {
        return UINib(nibName: "PopoverView", bundle: nil).instantiate(withOwner: nil, options: nil).first! as! PopoverView
    }
    

}
