//
//  L012Language.swift
//  IBety
//
//  Created by 68lion on 9/15/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class L012Localizer: NSObject {
    class func DoTheSwizzling() {
        // 1
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector:
            #selector(Bundle.specialLocalizedStringFor(key:value:table:))
            )
        MethodSwizzleGivenClassName(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.cstm_userInterfaceLayoutDirection))
    }
}

extension Bundle {
    
    @objc func specialLocalizedStringFor(key: String, value: String?, table tableName: String?) -> String {
        /*2*/let currentLanguage = L102Language.currentAppleLanguage()
        var bundle = Bundle();
        /*3*/if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: _path)!
        } else {
            let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            bundle = Bundle(path: _path)!
        }
        /*4*/return (bundle.specialLocalizedStringFor(key: key, value: value, table: tableName))
    }
}

        extension UIApplication {
            @objc var cstm_userInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        get {
        var direction = UIUserInterfaceLayoutDirection.rightToLeft
        if L102Language.currentAppleLanguage() == "en" {
        direction = .leftToRight
        }
        if L102Language.currentAppleLanguage() == "ar" {
                direction = .rightToLeft
            }
        return direction
        }
    }
            
            class func isRTL() -> Bool{
                return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
            }

}


class customNavBttn:UIButton{
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
        if L102Language.currentAppleLanguage() == "en"{
            
            if let image = self.image(for: .normal) {
                self.setImage( UIImage(cgImage: image.cgImage!, scale:image.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            }
        }
    }
}

extension UIViewController {
    func loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: [UIView] , cancelledTags:[Int]?) {
        
        var isTagIsCancel = false
        if subviews.count > 0 {
            for subView in subviews {
                
                isTagIsCancel = false
                if let tags = cancelledTags{
                for tag in tags{
                    if subView.tag == tag{
                        isTagIsCancel = true
                        break
                    }
                    }}
                if !isTagIsCancel{
                if subView.isKind(of:UIImageView.self) {
                    let toRightArrow = subView as! UIImageView
                    if let _img = toRightArrow.image {
                        /*1*/toRightArrow.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
                    }
                }
                else if subView.isKind(of:UIButton.self){

                    let imageBttn = subView as! UIButton
                    if let image = imageBttn.image(for: .normal) {
                        imageBttn.setImage( UIImage(cgImage: image.cgImage!, scale:image.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
                    }
                }else if let textView = subView as? UITextView {
                    
                    if UIApplication.isRTL() {
                         textView.textAlignment = NSTextAlignment.right
                    } else {
                        textView.textAlignment = NSTextAlignment.left
                    }
                    
                }else if let textView = subView as? UITextField {
                    
                    if UIApplication.isRTL() {
                        textView.textAlignment = NSTextAlignment.right
                    } else {
                        textView.textAlignment = NSTextAlignment.left
                    }
                    
                }else if let textView = subView as? UILabel {
                    
                    if UIApplication.isRTL() {
                        textView.textAlignment = NSTextAlignment.right
                    } else {
                        textView.textAlignment = NSTextAlignment.left
                    }
                    
                    }
                    /*2*/loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: subView.subviews, cancelledTags: cancelledTags)
                }
            }
        }
    }
}

extension String{
    
    func localizablString(loc:String) -> String{
        
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle.init(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    var localized:String{
        
        return NSLocalizedString(self, comment: "")
    }
}

/// Exchange the implementation of two methods for the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    print(overrideSelector)
    
        let overrideMethod: Method = (class_getInstanceMethod(cls, overrideSelector)!)
        
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
    
}
