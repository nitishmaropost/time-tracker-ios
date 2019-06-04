//
//  SemiCircleView.swift
//  Timely
//
//  Created by maropost on 03/06/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

//class SemiCircleView: UIView {
//
//
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//        let gc = UIGraphicsGetCurrentContext()
//        gc?.beginPath()
//        gc?.addArc(center: CGPoint(x: rect.origin.x, y: rect.origin.y), radius: rect.size.width/2, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(Double.pi/2), clockwise: true)
//        gc?.closePath()
//        gc?.setFillColor(UIColor.blue.cgColor)
//        gc?.fillPath()
//    }
//
//
//}


class SemiCircleView: UIView {
    
    var semiCirleLayer: CAShapeLayer!
    var viewColor: UIColor!
    

    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.viewColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if semiCirleLayer == nil {
            let arcCenter = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y)
            let circleRadius = bounds.size.width / 2
            let circlePath = UIBezierPath(arcCenter: arcCenter, radius: circleRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: false)
            
            semiCirleLayer = CAShapeLayer()
            semiCirleLayer.path = circlePath.cgPath
            semiCirleLayer.fillColor = self.viewColor.cgColor
            layer.addSublayer(semiCirleLayer)
            
            // Make the view color transparent
            backgroundColor = UIColor.clear
        }
    }
    
    
}
