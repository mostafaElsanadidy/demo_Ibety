//
//  UIView+.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

extension UIView{
    // var text = ""
    func hud(inView view: UIView, animated: Bool){
        self.frame = view.bounds
        self.isOpaque = false
        view.addSubview(self)
        //view.isUserInteractionEnabled = false
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        
    }
    
}
