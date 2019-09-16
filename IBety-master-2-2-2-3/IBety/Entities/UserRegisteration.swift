//
//  UserRegisteration.swift
//  IBety
//
//  Created by Mohamed on 7/17/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class UserRegisteration: NSObject, NSCoding{

        var name:String!
        var email:String!
        var mobile:String!
        var city:Int!
        var password:String!
        var type:String!
    
    required init(n:String, e:String, m:String, c:Int, p:String , t:String) {
        
        name = n
        email = e
        mobile = m
        city = c
        password = p
        type = t
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        name = aDecoder.decodeObject(forKey: "name") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        city = aDecoder.decodeObject(forKey: "city") as? Int
        password = aDecoder.decodeObject(forKey: "password") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String

    }
    
    
    public func encode(with aCoder: NSCoder) {
        
         aCoder.encode(name, forKey: "name")
         aCoder.encode(email, forKey: "age")
         aCoder.encode(mobile, forKey: "mobile")
         aCoder.encode(city, forKey: "city")
         aCoder.encode(password, forKey: "password")
         aCoder.encode(type, forKey: "type")
    }
}

class product_Details: NSObject {
    var productName:String = ""
    var productDescription:String = ""
    var productPrice:String = ""
    var productimageURLStr:String = ""
    var ProductID:Int = 0
}


struct project_Details{
    
    var projectName:String=""
    var projectDescription:String=""
    var projectCity_Id:Int=0
    var projectCategory_Id:Int=0
    var projectImage:String=""
    var projectLatitude:Double=0.0
    var projectLongitude:Double=0.0
    var projectAddress:String=""
    var projectEmail:String=""
    var projectPhone:String=""
    var productName:String=""
    var productDescription:String=""
    var productPrice:String=""
    var productImages:[String] = [""]
}

struct project_Info {
    
    var projectName:String!
    var projectDescription:String!
    var projectCity_ID:Int!
    var projectCategoryID:Int!
    var projectImageStr:String!
}





struct Category_Details{
    var categoryName:String = ""
    var categoryDescription:String = ""
    var categoryPrice:String = ""
    var categoryImageURLStr:String = ""
    var categoryID:Int = 0
}

struct MyOwner_Info {
    
    var ownerPhoneNumber:String!
    var ownerEmail:String!
    var latitude:Double!
    var longitude:Double!
}

struct CategoryProject_Details{
    var projectName:String = ""
    //    var categoryDescription:String = ""
    //    var categoryPrice:String = ""
    var projectImageURLStr:String = ""
    var projectID:Int = 0
}


struct notification_Data{
    
    var title:String?
    var body:String?
    var createdDate:String?
    var createdTime:String?
}









