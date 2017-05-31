//
//  LatestProduct.swift
//  Zamroo
//
//  Created by Rohit Singh on 27/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class LatestProduct: NSObject {
    fileprivate var productId:String = ""//product_id
    fileprivate var productName:String = ""//product_name
    fileprivate var price:String = ""//price
    fileprivate var priceCat:String = ""//price_cat
    fileprivate var categoryId:String = ""//category_id
    fileprivate var subCategoryName:String = ""//sub_cat_name
    fileprivate var image:String = ""//image

    
    var _iproductId : String {
        set { self.productId = newValue }
        get { return self.productId}
    }
    
    var _productName : String {
        set { self.productName = newValue }
        get { return self.productName}
    }
    
    var _price : String {
    set { self.price = newValue }
    get { return self.price}
    }
    
    var _priceCat : String {
    set { self.priceCat = newValue }
    get { return self.priceCat}
    }
    
    var _categoryId : String {
    set { self.categoryId = newValue }
    get { return self.categoryId}
    }
    
    var _subCategoryName: String {
    set { self.subCategoryName = newValue }
    get { return self.subCategoryName}
    }
    
    var _image : String {
    set { self.image = newValue }
    get { return self.image}
    }

}
