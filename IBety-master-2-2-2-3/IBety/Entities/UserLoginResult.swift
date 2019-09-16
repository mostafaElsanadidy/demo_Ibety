//
//  UserLoginResult.swift
//  IBety
//
//  Created by Mohamed on 7/8/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation


struct UserLoginReult: Decodable {
    var data:UserData?
    var token:String?
}

struct UserData: Decodable {
    var id:Int?
    var name:String?
    var email:String?
    var mobile:String?
    var address:String?
    var type:String?
    var gender:String?
    var verified:Bool?
    var avatar:String?
    var avatar_conversions:[String : String]?
    var links:[String]?
}

struct countriesResult : Decodable{
    
    var data: [countriesData]?
}

struct countriesData : Decodable {
    var id: Int?
    var name: String?
    var code :String?
    var key :String?
    var is_default :Bool?
    var flag:String?
    var links:dataLink?
}

struct dataLink:Decodable {
    var show:dataLinkShow?
}

struct dataLinkShow:Decodable {
    var href:String?
    var method:String?
}


struct CategoryResult : Decodable {
    var data : [categoriesData]?
}

struct categoriesData : Decodable {
    var id : Int?
    var name : String?
    var media : categoriesDataMedia?
    var links:categoriesDataLinks?
}

struct categoriesDataMedia : Decodable {
    var image : mediaImage?
}

struct mediaImage : Decodable {
    var id: Int?
    var name: String?
    var url :String?
    var type :String?
    var size :Int?
    var collections:String?
    var conversions : categoriesConversions?
    var links:imageDataLink?
}

struct imageDataLink : Decodable{
    var delete: dataLinkShow?
}

struct categoriesDataLinks :Decodable {
    var show: dataLinkShow?
    var projects : dataLinkShow?
}

struct categoriesConversions : Decodable {
    var thumb : String?
    var small : String?
    var medium : String?
    var large : String?
}






struct UserLogin_Reult: Decodable {
    var data:User_Data?
    var token:String?
}

struct User_Data: Decodable {
    var id:Int?
    var name:String?
    var email:String?
    var phone_number:String?
    //  var address:String?
    var type:String?
    var localed_type:String?
    var projects:projectDetails?
    // var gender:String?
    var verified:Bool?
    var expire_at:String?
    var avatar:String?
    //var avatar_conversions:[String : String]?
    var links:[String]?
}

struct projectDetails: Decodable {
    var count:Int?
}



struct errorMessage: Decodable{
    var message:String?
    var errors:errorsKey?
}

struct errorsKey: Decodable{
    var email:[String]?
    var phone_number:[String]?
    var city_id:[String]?
    var project_city_id:String?
}









struct OwnerLogin_Result: Decodable {

    var data:Owner_Data?
    var token:String?
}

struct Owner_Data : Decodable {
    
    var id:Int?
    var name:String?
    var email:String?
    var phone_number:String?
    //  var address:String?
    var type:String?
    var localed_type:String?
    var projects:projects_DetailsResult?
    // var gender:String?
    var verified:Bool?
    var expire_at:String?
    var avatar:String?
    var city:citiesData?
    //var avatar_conversions:[String : String]?
   // var links:DataLinks?
}

struct projects_DetailsResult: Decodable {
    var count:Int?
    var data: projectsData?
}

struct projectsData : Decodable {
    var id : Int?
    var name : String?
    var description : String?
    var address : String?
    var location:projectsDataLocation?
    var media : categoriesDataMedia?
    var links : SearchProjectsDataLinks?//
}

struct projectsDataLocation: Decodable {
    
    var latitude:String?
    var longitude:String?
}

struct ProjectsDataLinks : Decodable {
    var show : dataLinkShow?
    var products : dataLinkShow?
    var delete : dataLinkShow?
    var createProduct : dataLinkShow?
}

struct DataLinks : Decodable {
    var show : dataLinkShow?
    var update : dataLinkShow?
   
}

struct citiesData : Decodable {
    var id: Int?
    var name: String?
    var country: countriesData?}



struct User_Profile:Decodable{
    var data : User_ProfileData!
    
}
struct User_ProfileData:Decodable {
    var id:Int!
    var name:String!
    var avatar:String!
    var email:String!
    var phone_number:String!
    var type:String!
    var localed_type:String!
}







struct defaultCities : Decodable{
    var data : defaultCitiesData?
}

struct defaultCitiesData : Decodable {
    var id: Int?
    var name: String?
    var code :String?
    var key :String?
    var is_default :Bool?
    var flag:String?
    var cities:[defaultCity]?
    var links:dataLink?
}

struct defaultCity : Decodable {
    var id : Int?
    var name : String?
}





struct projectCreationDetails:Decodable{
    
    var data:projectCreationData?
}

struct projectCreationData:Decodable {
    var id:Int?
    var name:String?
    var description:String?
    var owner: Owner_Data?
    var category:categoriesData?
    var city:defaultCity?
    var address:String?
    var location:projectsDataLocation?
    var media:categoriesDataMedia?
    var products:productDetails?
    var links:ProjectsDataLinks?
}

struct productDetails:Decodable{
    
    var data:[product_Data]?
}

struct DisplayedProducts:Decodable{
    
    var data: [product_Data_]?
    var links: DisplayedProductsLinks?
    var meta: DisplayedProductsMeta?
}

struct product_Data_:Decodable {
    var id:Int?
    var name:String?
    var description:String?
    var price: String?
    var price_formated:String?
    var media:product_media?
    var links:productLinks?
}

struct product_Data:Decodable {
    var id:Int?
    var name:String?
    var description:String?
    var price: String?
    var price_formated:String?
    var media:productmedia?
    var links:productLinks?
}

struct product_media:Decodable {
    var images : [mediaImage]?
}

struct productmedia:Decodable {
    var image : [mediaImage]?
}

struct productLinks:Decodable {
    var show: dataLinkShow?
    var delete : dataLinkShow?
}

struct DisplayedProductsLinks: Decodable {
    var first:String?
    var last:String?
    var prev:String?
    var next:String?
}

struct DisplayedProductsMeta:Decodable {
    var current_page:Int?
    var from:Int?
    var last_page:Int?
    var path:String?
    var per_page:Int?
    var to:Int?
    var total:Int?
}









struct displayedProduct : Decodable {
    var data:displayedProductData?
}

struct displayedProductData:Decodable{
    
    var id:Int?
    var name:String?
    var description:String?
    var price: String?
    var price_formated:String?
    var project:displayedProjectProduct?
    var media:product_media?
    var links:productLinks?
}


struct displayedProjectProduct:Decodable {
    var id:Int?
    var name:String?
    var description:String?
    var owner: Owner_Data?
   // var category:categoriesData?
    var address:String?
    var location:projectsDataLocation?
    var media:categoriesDataMedia?
   // var products:productDetails?
    var links:ProjectsDataLinks?//
}






struct DisplayedSearchedProducts:Decodable{
    
    var data: [DisplayedSearchedProductsData]?
    var links: SearchProjectsDataLinks?
    var meta: DisplayedProductsMeta?
}

struct DisplayedSearchedProductsData:Decodable  {
    
    var id:Int?
    var name:String?
    var description:String?
    var owner: Owner_Data_?
    var city:citiesData?
    var address:String?
    var location:projectsDataLocation?
    var media:categoriesDataMedia?
    // var products:productDetails?
    var links:SearchProjectsDataLinks?//
}

struct SearchProjectsDataLinks : Decodable {
    var show : dataLinkShow?
    var products : dataLinkShow?
}

struct Owner_Data_ : Decodable {
    
    var id:Int?
    var name:String?
    var email:String?
    var phone_number:String?
    //  var address:String?
    var type:String?
    var localed_type:String?
    var projects:projects_DetailsResult?
    // var gender:String?
    var verified:Bool?
    var expire_at:String?
    var avatar:String?
    var city:citiesData?
   // var links:[DataLinks]?
}









struct CategoryProjects:Decodable{
    
    var data: [CategoryProjectsData]?
    var links: SearchProjectsDataLinks?
    var meta: DisplayedProductsMeta?
}

struct CategoryProjectsOwner_Data : Decodable {
    
    var id:Int?
    var name:String?
    var email:String?
    var phone_number:String?
    var address:String?
    var type:String?
    var localed_type:String?
    var projects:projects_DetailsResult?
    // var gender:String?
    var verified:Bool?
    var expire_at:String?
    var avatar:String?
    var city:citiesData?
    var links:[DataLinks]?
}

struct CategoryProjectsData:Decodable  {
    
    var id:Int?
    var name:String?
    var description:String?
    var owner: CategoryProjectsOwner_Data?
    var city:citiesData?
    var address:String?
    var location:projectsDataLocation?
    var media:categoriesDataMedia?
    // var products:productDetails?
    var links:SearchProjectsDataLinks?//
}


//struct errorsData:Decodable {
//    var name:[String]!
//    var phone_number:[String]!
//    var city_id:[String]!
//    var email:[String]!
//    var password:[String]!
//}

struct ApplicationSettings:Decodable{
    var data:ApplicationSettingsData?
}

struct ApplicationSettingsData:Decodable{
    
    var phone1:String?
    var phone2:String?
    var phone3:String?
    var report_phone:String?
    var suggest_phone:String?
    var email:String?
    var about:String?
    var terms:String?
    var facebook:String?
    var twitter:String?
    var snapchat:String?
    var instagram:String?
}




struct NotificationsSettings:Decodable{
    
    var data:[NotificationsSettingsData]?
}

struct NotificationsSettingsData:Decodable{
    
    var id:String?
    var title:String?
    var body:String?
    var type:String?
    var dates:NotificationsSettingsDates?
}

struct NotificationsSettingsDates:Decodable{
    var created_at:NotificationsSettingsCreatedDates?
    var updated_at:NotificationsSettingsCreatedDates?
}

struct NotificationsSettingsCreatedDates:Decodable{
    var date:String?
    var formated:String?
}



struct CheckCodeServiceResult:Decodable {
    var token:String!
}

