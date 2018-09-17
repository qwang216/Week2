
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
        label.font = UIFont(name: "BebasNeue-Regular", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let shapeLayer = CAShapeLayer()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(timeStampLabel)
        timeStampLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        timeStampLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true


        // Draw Circle path
        let radius = (bounds.size.width - 20) / 2
        let startAngle: CGFloat = 0
        let endAngle = CGFloat.pi * 2
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        // Draw track path
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = center
        layer.addSublayer(trackLayer)

        // Draw progress Path
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.circularLoaderStrokeColor().cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.position = center
        shapeLayer.strokeEnd = 0

        layer.addSublayer(shapeLayer)
    }

    func startAnimate(with percentCompletion: CGFloat) {
        shapeLayer.strokeEnd = percentCompletion
    }

}
