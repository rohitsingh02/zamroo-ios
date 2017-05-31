//
//  Product.swift
//  Zamroo
//
//  Created by Rohit Singh on 27/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class Product: NSObject {
    fileprivate var productId:String = ""//product_id
    fileprivate var userId:String = ""//user_id
    fileprivate var subCategoryId:String = ""//sub_cat_id
    fileprivate var productName:String = ""//product_name
    fileprivate var productDescription:String = ""//product_description
    fileprivate var price:String = ""//price
    fileprivate var priceCat:String = ""//price_cat
    fileprivate var productImage:String = ""//product_image
    fileprivate var categoryId:String = ""//category_id
    fileprivate var dateModified:String = ""//date_modified
    fileprivate var categoryName:String = ""//category_name
    fileprivate var subCategoryName:String = ""//sub_cat_name
    fileprivate var city:String = ""//city
    fileprivate var userEmail:String = ""//user_email
    fileprivate var firstName:String = ""//first_name
    fileprivate var mobileNumber:String = ""//mobile_no
    fileprivate var whatsapp:String = ""//whatsapp
    fileprivate var stateId:String = ""//state_id
    fileprivate var cityId:String = ""//city_id
    
    var _productId : String {
        set { self.productId = newValue }
        get { return self.productId}
    }
    var _userId : String {
        set { self.userId = newValue }
        get { return self.userId}
    }
    var _subCategoryId : String {
        set { self.subCategoryId = newValue }
        get { return self.subCategoryId }
    }
    var _productName : String {
        set { self.productName = newValue }
        get { return self.productName  }
    }
    var _productDescription : String {
        set { self.productDescription = newValue }
        get { return self.productDescription  }
    }
    var _price : String {
        set { self.price = newValue }
        get { return self.price }
    }
    var _priceCat : String {
        set { self.priceCat = newValue }
        get { return self.priceCat }
    }
    var _productImage : String {
        set { self.productImage = newValue }
        get { return self.productImage }
    }
    var _categoryId : String {
        set { self.categoryId = newValue }
        get { return self.categoryId }
    }
    var _dateModified : String {
        set { self.dateModified = newValue }
        get { return self.dateModified }
    }
    var _categoryName : String {
        set { self.categoryName = newValue }
        get { return self.categoryName}
    }
    var _subCategoryName : String {
        set { self.subCategoryName = newValue }
        get { return self.subCategoryName }
    }
    var _city : String {
        set { self.city = newValue }
        get { return self.city }
    }
    var _userEmail : String {
        set { self.userEmail = newValue }
        get { return self.userEmail }
    }
    var _firstName : String {
        set { self.subCategoryName = newValue }
        get { return self.subCategoryName }
    }
    var _mobileNumber : String {
        set { self.subCategoryName = newValue }
        get { return self.subCategoryName }
    }
    var _whatsapp : String {
        set { self.whatsapp = newValue }
        get { return self.whatsapp }
    }
    var _stateId: String {
        set { self.stateId = newValue }
        get { return self.stateId}
    }
    var _cityId : String {
        set { self.cityId = newValue }
        get { return self.cityId}
    }
    
}
