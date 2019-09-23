//
//  UIImage+Resize.swift
//  IBety
//
//  Created by Mohamed on 6/19/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Alamofire

extension UIImage {
    func resizedImage(withBounds bounds: CGSize) -> UIImage {
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
    }
        
        func downloadImages(imageURL: String) -> UIImage! {
            
            Alamofire.request(imageURL, method: .get)
                .validate()
                .responseData(completionHandler: { (responseData) in
                    return UIImage(data: responseData.data!)
                })
            return nil
        }
}

extension String {
    mutating func add(text: String?, separatedBy separator: String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text }
    } }

