//
//  LanguageViewController.swift
//  IBety
//
//  Created by Mohamed on 7/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import SSCustomTabbar

//let APPLE_LANGUAGE_KEY = "AppleLanguages"

class LanguageViewController: UIViewController {

    @IBOutlet weak var cancelBttn: UIButton!
    @IBOutlet weak var saveBttn: UIButton!
    
    var presenter:LanguageViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LanguageRouter.createModule(view: self)
        presenter?.viewDidLoad()
        saveBttn.layer.cornerRadius = 5
        cancelBttn.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func arabicLanguage() {

           presenter?.setArabicLanguage()
    }
    
    @IBAction func englishLanguage() {
        
           presenter?.setEnglishLanguage()
    }
    
    
    
    @IBAction func cancelPage() {
        
        presenter?.cancelPage()
    }

    /*
    // MARK: - Navigation
     @IBOutlet weak var saveBttn: UIButton!
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
//    class func currentAppleLanguage() -> String{
//        let userdef = UserDefaults.standard
//        let langArray = userdef.object(forKey:APPLE_LANGUAGE_KEY) as! NSArray
//        let current = langArray.firstObject as! String
//        return current
//    }
//    /// set @lang to be the first in Applelanguages list
//    class func setAppleLAnguageTo(lang: String) {
//        let userdef = UserDefaults.standard
//        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
//        userdef.synchronize()
//    }
}



//
//class LanguageDetails: NSObject {
//    
//    var language: String!
//    var bundle: Bundle!
//    let LANGUAGE_KEY: String = "LANGUAGE_KEY"
//    
//    override init() {
//        super.init()
//        
//        // user preferred languages. this is the default app language(device language - first launch app language)!
//        language = Bundle.main.preferredLocalizations[0]
//        
//        // the language stored in UserDefaults have the priority over the device language.
//        
//        language = UserDefaults.standard.string(forKey: LANGUAGE_KEY)
//       // language = Common.valueForKey(key: LANGUAGE_KEY, default_value: language as AnyObject) as! String
//        
//        // init the bundle object that contains the localization files based on language
//        bundle = Bundle(path: Bundle.main.path(forResource: language == "en" ? language : "Base", ofType: "lproj")!)
//        
//        // bars direction
//        if isEnglish() {
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//        } else {
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//        }
//    }
//    
//    // check if current language is arabic
//    func isEnglish () -> Bool {
//        return language == "en"
//    }
//    
//    // returns app language direction.
//    func rtl () -> Bool {
//        return Locale.characterDirection(forLanguage: language) == Locale.LanguageDirection.leftToRight
//    }
//    
//    // switches language. if its ar change it to en and vise-versa
//    func changeLanguage()
//    {
//        var changeTo: String
//        // check current language to switch to the other.
//        if language == "ar" {
//            changeTo = "en"
//        } else {
//            changeTo = "ar"
//        }
//        
//        // change language
//        changeLanguageTo(lang: changeTo)
//        
////        loginfo("Language changed to: \(language)")
//    }
//    
//    // change language to a specfic one.
//    func changeLanguageTo(lang: String) {
//        language = lang
//        
//        // set language to user defaults
//        
//        UserDefaults.standard.set(language, forKey: LANGUAGE_KEY)
//        
//        
//        // set prefered languages for the app.
//        UserDefaults.standard.set([lang], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//        
//        // re-set the bundle object based on the new langauge
//        bundle = Bundle(path: Bundle.main.path(forResource: language == "en" ? language : "Base", ofType: "lproj")!)
//        
//        // app direction
//        if isEnglish() {
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//        } else {
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//        }
//        
//       // Log.info("Language changed to: \(language)")
//    }
//    
//    // get local string
//    func getLocale() -> NSLocale {
//        if rtl() {
//            return NSLocale(localeIdentifier: "ar_JO")
//        } else {
//            return NSLocale(localeIdentifier: "en_US")
//        }
//    }
//    
//    // get localized string based on app langauge.
//    func LocalString(key: String) -> String {
//        let localizedString: String? = NSLocalizedString(key, bundle: bundle, value: key, comment: "")
//        //        Log.ver("Localized string '\(localizedString ?? "not found")' for key '\(key)'")
//        return localizedString ?? key
//    }
//    
//    // get localized string for specific language
//    func LocalString(key: String, lan: String) -> String {
//        let bundl:Bundle! = Bundle(path: Bundle.main.path(forResource: lan == "ar" ? lan : "Base", ofType: "lproj")!)
//        return NSLocalizedString(key, bundle: bundl, value: key, comment: "")
//    }
//}












//class L012Localizer: NSObject {
//    class func DoTheSwizzling() {
//        // 1
//        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: NSSelectorFromString("localizedStringForKey:value:table:"), overrideSelector: NSSelectorFromString("specialLocalizedStringForKeykey:value:table:"))
//        
//    }
//}
//extension Bundle {
//
//
//
//    func specialLocalizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
//        /*2*/let currentLanguage = LanguageViewController.currentAppleLanguage()
//        var bundle = Bundle();
//        /*3*/if let _path = Bundle.main.path(forResource:currentLanguage, ofType: "lproj") {
//            bundle = Bundle(path: _path)!
//        } else {
//            let _path = Bundle.main.path(forResource:"Base", ofType: "lproj")!
//            bundle = Bundle(path: _path)!
//        }
//        //bundle.loca
//        /*4*/return (bundle.specialLocalizedStringForKey(key: key, value: value, table: tableName))
//    }
//}
///// Exchange the implementation of two methods for the same Class
//func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
//    let origMethod: Method = (class_getInstanceMethod(cls, originalSelector))!
//    let overrideMethod: Method = (class_getInstanceMethod(cls, overrideSelector))!
//    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
//        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
//    } else {
//        method_exchangeImplementations(origMethod, overrideMethod);
//    }
//}
//
