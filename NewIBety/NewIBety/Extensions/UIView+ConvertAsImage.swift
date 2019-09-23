//
//  UIView+ConvertAsImage.swift
//  IBety
//
//  Created by Mohamed on 6/24/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    
    func showSpinner(tag:Int){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    let spinner = UIActivityIndicatorView(
        style: .gray)
    spinner.center = CGPoint(x: self.bounds.midX + 0.5,
    y: self.bounds.midY + 0.5)
    spinner.tag = tag
    self.addSubview(spinner)
    spinner.startAnimating()
    }
    
    func hideSpinner(tag:Int){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.viewWithTag(tag)?.removeFromSuperview()
    }
    
    
    func createRectangle() -> CGPath {
        // Initialize the path.
        let path = UIBezierPath()
        
        self.layer.cornerRadius = 8
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4.0
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        path.move(to: CGPoint(x: 0.0, y: 5.0))
        path.addLine(to: CGPoint(x: self.bounds.width/2, y: self.bounds.height/2))
        print(self.bounds.width)
        path.addLine(to: CGPoint(x: self.bounds.width, y: 5.0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height+5.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.bounds.height+5.0))
        
        return path.cgPath
    }

}

extension UIImage {
    func resized_Image(withBounds bounds: CGSize) -> UIImage {
        let horizontalRatio = bounds.width / size.width
        let verticalRatio = bounds.height / size.height
        let ratio = min(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio,
                             height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }}


class paddingTextView:UITextView{
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override var contentInset: UIEdgeInsets{
        
        get{
            
            return padding
        }
        set{
            self.contentInset = padding
        }
    }
    
    override var layoutMargins: UIEdgeInsets{
        
        get{
            
            return padding
        }
        set{
            self.layoutMargins = padding
        }
    }
    
//    override var safeAreaInsets: UIEdgeInsets{
//
//        get{
//
//            return padding
//        }
//        set{
//            self.safeAreaInsets = padding
//        }
//    }
    
    override var textContainerInset: UIEdgeInsets{
        
        get{
            
            return padding
        }
        set{
            self.textContainerInset = padding
        }
    }
    
//    override var alignmentRectInsets: UIEdgeInsets{
//
//        get{
//
//            return padding
//        }
//        set{
//            self.alignmentRectInsets = padding
//        }
//    }
    
    override var adjustedContentInset: UIEdgeInsets{
        
        get{
            
            return padding
        }
        set{
            self.adjustedContentInset = padding
        }
    }
    
}
