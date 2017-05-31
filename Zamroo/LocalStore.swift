//
//  LocalStore.swift
//  Designers News
//
//  Created by Rohit Singh on 07/04/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit


struct LocalStore {

    static let userDefaults = UserDefaults.standard
    
    static func saveCityName(_ cityName : String){
        userDefaults.set(cityName, forKey: "City")
        
    }
    
    static func getCityName() -> String?{
        
        return userDefaults.value(forKey: "City") as? String
        
    }
    
    static func saveCityId(_ cityId: Int){
        userDefaults.set(cityId, forKey: "CityId")
        
    }
    
    static func getCityId() -> Int?{
        
        return userDefaults.value(forKey: "CityId") as? Int
        
    }
    
    static func saveStateId(_ stateId: Int){
        userDefaults.set(stateId, forKey: "StateId")
        
    }
    
    static func getStateId() -> Int?{
        
        return userDefaults.value(forKey: "StateId") as? Int
        
    }
    
    
    static func saveCurrentCategory(_ category:String){
        userDefaults.set(category, forKey: "Category")
        
    }
    
    static func getCurrentCategory() -> String{
        return userDefaults.value(forKey: "Category") as! String
        
    }
    
    static func saveUserApiKey(_ category:String){
        userDefaults.set(category, forKey: "ApiKey")
        
    }
    
    static func getUserApiKey() -> String{
        return userDefaults.value(forKey: "ApiKey") as! String
        
    }
  
    static func saveAlreadyLogin(_ isLogin:Bool?){
        userDefaults.set(isLogin, forKey: "ISLOGIN")
        
    }
    
    static func getAlreadyLogin() -> Bool?{
        return userDefaults.value(forKey: "ISLOGIN") as! Bool?
        
    }
    
    static func saveSubCategoryId(_ subCategoryId : Int){
        userDefaults.set(subCategoryId, forKey: "SubCategoryId")
        
    }
    
    static func getSubCategoryId() -> Int{
        return userDefaults.value(forKey: "SubCategoryId") as! Int
        
    }
    
    static func saveMultipleSelectionArray1(_ multipleSelectionArray : [String]){
        userDefaults.set(multipleSelectionArray, forKey: "MultipleSelection1")
        
    }
    
    static func getMultipleSelectionArray1() -> [String]{
        return userDefaults.value(forKey: "MultipleSelection1") as! [String]
        
    }
    static func saveMultipleSelectionArray2(_ multipleSelectionArray : [String]){
        userDefaults.set(multipleSelectionArray, forKey: "MultipleSelection2")
        
    }
    
    static func getMultipleSelectionArray2() -> [String]{
        return userDefaults.value(forKey: "MultipleSelection2") as! [String]
        
    }
   
   static func removeObject(key:String){
    
       userDefaults.removeObject(forKey: key)
    }
}
