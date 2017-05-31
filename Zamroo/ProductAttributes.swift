//
//  ProductAttributes.swift
//  Zamroo
//
//  Created by Rohit Singh on 27/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class ProductAttributes: NSObject {
    fileprivate var sellerType:String = ""//Seller Type
    fileprivate var noOfRooms:String = ""//No. of Romms
    fileprivate var area:String = ""//Area
    fileprivate var carParking:String = ""//Car Parking
    fileprivate var bathrooms:String = ""//Bathrooms
    fileprivate var propertyType:String = ""//Property Type
    fileprivate var balconies:String = ""//Balconies
    fileprivate var floorNumber:String = ""//Floor Number
    fileprivate var propertyOwnership:String = ""//Property Ownership
    fileprivate var furnished:String = ""//Furnished
    
    var _sellerType : String {
        set { self.sellerType = newValue }
        get { return self.sellerType}
    }
    
    var _noOfRooms : String {
        set { self.noOfRooms = newValue }
        get { return self.noOfRooms}
    }
    
    var _area : String {
        set { self.area = newValue }
        get { return self.area}
    }
    
    var _carParking : String {
        set { self.carParking = newValue }
        get { return self.carParking}
    }
    
    var _bathrooms : String {
        set { self.bathrooms = newValue }
        get { return self.bathrooms}
    }
    
    var _propertyType : String {
        set { self.propertyType = newValue }
        get { return self.propertyType}
    }
    
    var _balconies : String {
        set { self.balconies = newValue }
        get { return self.balconies}
    }
    
    var _floorNumber : String {
        set { self.floorNumber = newValue }
        get { return self.floorNumber}
    }
    
    var _propertyOwnership : String {
        set { self.propertyOwnership = newValue }
        get { return self.propertyOwnership}
    }
    
    var _furnished: String {
        set { self.furnished = newValue }
        get { return self.furnished  }
    }
    
}
