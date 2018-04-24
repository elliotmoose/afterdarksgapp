//
//  CircleProgressView.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 24/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class CircleProgressView: UIView {

    public var strokeColor : UIColor = UIColor.red
    public var trackColor : UIColor = UIColor.white
    
    public var lineWidth : CGFloat = 10
    
    public var progress : Float = 0
    private let progressCircleLayer = CAShapeLayer()
    private let trackCircleLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func Initialize(strokeColor : UIColor)
    {
        self.strokeColor = strokeColor
        
        var radius : CGFloat = 0
        if self.frame.width > self.frame.height
        {
            radius = self.frame.height/2
        }
        else
        {
            radius = self.frame.width/2
        }
        
        
        let center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -.pi/2, endAngle: .pi*2 - .pi/2, clockwise: true)
        
        
        progressCircleLayer.path = circularPath.cgPath
        progressCircleLayer.fillColor = nil
        progressCircleLayer.strokeColor = strokeColor.cgColor
        progressCircleLayer.lineWidth = lineWidth
        progressCircleLayer.lineCap = kCALineCapRound
//        progressCircleLayer.anchorPoint = center


        let gap : CGFloat = 10
        let innerCircularPath = UIBezierPath(arcCenter: center, radius: radius-lineWidth-gap, startAngle: -.pi/2, endAngle: .pi*2 - .pi/2, clockwise: true)
        
        
        trackCircleLayer.path = innerCircularPath.cgPath
        trackCircleLayer.fillColor = nil
        trackCircleLayer.strokeColor = trackColor.cgColor
        trackCircleLayer.lineWidth = lineWidth
        //trackCircleLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.layer.addSublayer(progressCircleLayer)
        self.layer.addSublayer(trackCircleLayer)
        
        

        
        SetProgressValue(0.5)
    }
    
    public func SetProgressValue(_ value : Float)
    {
        
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.fromValue = progress
        anim.toValue = value
        anim.duration = 1
        anim.fillMode = kCAFillModeForwards
        anim.isRemovedOnCompletion = false
        progressCircleLayer.add(anim, forKey: "basic")
        
        progress = value
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
