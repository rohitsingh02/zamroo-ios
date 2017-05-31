//
//  DataHelper.swift
//  Zamroo
//
//  Created by Rohit Singh on 02/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit


class DataHelper: NSObject {
    
    static func getFeatureProductObject(_ json: JSON) -> FeatureProduct {
        
        let productId = json[""].stringValue
        let productName = json[""].stringValue
        let price = json[""].stringValue
        let priceCat = json[""].stringValue
        let categoryId = json[""].stringValue
        let subCategoryId = json[""].stringValue
        let prodId = json[""].stringValue
        let image = json[""].stringValue
        let categoryImage = json[""].stringValue
        let categoryName = json[""].stringValue
        let subCategoryName = json[""].stringValue
        
        return FeatureProduct(productId: productId, productName: productName, price: price, priceCat: priceCat, categoryId: categoryId, subCategoryId: subCategoryId, prodId: prodId, image: image, categoryImage: categoryImage, categoryName: categoryName, subCategoryName: subCategoryName)
    }
    
    static func getStateObject(_ json: JSON) -> State {
        
       
        let stateId = json["state_id"].stringValue
        let state = json["state"].stringValue
        let status = json["status"].stringValue
       
        
        return State(stateId: stateId, state: state, status: status)
    }
    
    static func getCityObject(_ json: JSON) -> City {
        
        
        let cityId = json["city_id"].stringValue
        let city = json["city"].stringValue
        let locationId = json["location_id"].stringValue
        
        
        return City(cityId: cityId, city: city, locationId: locationId)
    }

}
