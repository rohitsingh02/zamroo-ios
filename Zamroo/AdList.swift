//
//  AdList.swift
//  Zamroo
//
//  Created by Rohit Singh on 27/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class AdList: NSObject {
    fileprivate var productId:String = ""//product_id
    fileprivate var userId:String = ""//user_id
    fileprivate var subCategoryId:String = ""//sub_cat_id
    fileprivate var productName:String = ""//product_name
    fileprivate var price:String = ""//price
    fileprivate var priceCat:String = ""//price_cat
    fileprivate var categoryId:String = ""//category_id
    fileprivate var dateModified:String = ""//date_modified
    fileprivate var categoryName:String = ""//category_name
    fileprivate var subCategoryName:String = ""//sub_cat_name
    fileprivate var cityId:String = ""//city_id
    fileprivate var city:String = ""//city
    fileprivate var image:String = ""//image
    
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
    var _price : String {
        set { self.price = newValue }
        get { return self.price }
    }
    var _priceCat : String {
        set { self.priceCat = newValue }
        get { return self.priceCat }
    }
    var _categoryId : String {
        set { self.categoryId = newValue }
        get { return self.categoryId }
    }
    var _dateModified : String {
        set { self.dateModified = newValue }
        get { return self.dateModified }
    }
    var _subCategoryName : String {
        set { self.subCategoryName = newValue }
        get { return self.subCategoryName }
    }
    var _categoryName : String {
        set { self.categoryName = newValue }
        get { return self.categoryName}
    }
    var _cityId : String {
        set { self.cityId = newValue }
        get { return self.cityId}
    }
    var _city: String {
        set { self.city = newValue }
        get { return self.city}
    }
    var _image : String {
        set { self.image = newValue }
        get { return self.image }
    }
   
   
}
