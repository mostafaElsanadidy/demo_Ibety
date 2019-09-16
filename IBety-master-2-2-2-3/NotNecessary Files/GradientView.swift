//
//  GradientView.swift
//  IBety
//
//  Created by Mohamed on 7/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class GradientView: UIButton {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let components: [CGFloat] = [ 128, 173, 40, 1, 87, 138, 40, 1]
        let locations: [CGFloat] = [ 0, 1 ]
        // 2
        print(" mostafa*************** ")
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorSpace: colorSpace,
            colorComponents: components, locations: locations, count: 2)
        //UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0.0)
       
        let x = bounds.midX
        let y = bounds.midY
        let centerPoint = CGPoint(x: x, y : y)
        let radius = max(x, y)
        
        let frame = self.frame
        let x1 = frame.origin.x
       
        let y1 = frame.origin.y
         print("\(x1) \(y1)")
        
        let context = UIGraphicsGetCurrentContext()
        context?.drawRadialGradient(gradient!, startCenter: centerPoint, startRadius: 0, endCenter: centerPoint, endRadius: radius, options: .drawsAfterEndLocation)
       // context?.drawLinearGradient(gradient!, start: CGPoint(x: x1, y: 468+y1), end: CGPoint(x: x1+5, y: y1+frame.height), options: .drawsAfterEndLocation)
        //UIGraphicsEndImageContext()
    }
    

}
