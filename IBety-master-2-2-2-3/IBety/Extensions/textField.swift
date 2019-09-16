//
//  textField.swift
//  IBety
//
//  Created by Mohamed on 7/17/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class textField: UITextField {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        self.layer.cornerRadius = 10
        // Drawing code
    }
    
        
        let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    
}
