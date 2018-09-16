//
//  PopoverViewCell.swift
//  Week2
//
//  Created by Jason wang on 9/16/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class PopoverViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!

    static func instantiateViewFromxib() -> PopoverViewCell {
        return UINib(nibName: "PopoverView", bundle: nil).instantiate(withOwner: nil, options: nil)[1] as! PopoverViewCell
    }

}
