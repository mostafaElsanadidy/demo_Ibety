//
//  demoButton.swift
//  IBety
//
//  Created by Mohamed on 6/19/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class demoButton: UIButton {

    
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //    let width: CGFloat = 240.0
    //    let height: CGFloat = 160.0
    //
    //    let demoView = DemoView(frame: CGRect(x: self.view.frame.size.width/2 - width/2,
    //                                          y: self.view.frame.size.height/2 - height/2,
    //                                          width: width,
    //                                          height: height))
    //
    //    self.view.addSubview(demoView)
    
    
    override func draw(_ rect: CGRect) {
        //        self.createRectangle()
//        path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: 10)
        
       
        
        path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft , .topLeft], cornerRadii: CGSize(width: 7, height: 0))
        // Specify the fill color and apply it to the path.
        
        UIColor.clear.setFill()
                path.fill()
        
        // Specify a border (stroke) color.
        UIColor.lightGray.setStroke()
        path.stroke()
        
       
        self.layer.shadowOpacity=0.1
        
    }
    

}
