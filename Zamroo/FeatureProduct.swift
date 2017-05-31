//
//  FeatureProduct.swift
//  Zamroo
//
//  Created by Rohit Singh on 27/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class FeatureProduct: NSObject {
    var productId:String//product_id
     var productName:String//product_name
     var price:String//price
     var priceCat:String//price_cat
     var categoryId:String//category_id
     var subCategoryId:String//sub_cat_id
     var prodId:String//prod_id
     var image:String//image
     var categoryImage:String//category_image
     var categoryName:String//category_name
     var subCategoryName:String//sub_cat_name
 
    init(productId:String,productName:String,price:String,priceCat:String,categoryId:String,subCategoryId:String,prodId:String,image:String,categoryImage:String,categoryName:String,subCategoryName:String){
        self.productId = productId
        self.productName = productName
        self.price = price
        self.priceCat = priceCat
        self.categoryId = categoryId
        self.subCategoryId = subCategoryId
        self.prodId = prodId
        self.image = image
        self.categoryImage = categoryImage
        self.categoryName = categoryName
        self.subCategoryName = subCategoryName
        
    }

}
