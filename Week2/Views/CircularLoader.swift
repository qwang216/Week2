
//
//  CircularLoader.swift
//  Week2
//
//  Created by Jason wang on 9/14/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class CircularLoader: UIView {

    lazy var timeStampLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        addSubview(timeStampLabel)
        timeStampLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        timeStampLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        let radius = (bounds.size.width - 20) / 2
        let startAngle = -CGFloat.pi / 2
        let endAngle = CGFloat.pi * 2
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.circularLoaderStrokeColor().cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound

        layer.addSublayer(shapeLayer)

    }
}
