//
//  City.swift
//  Zamroo
//
//  Created by Rohit Singh on 27/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class City: NSObject {

     var cityId:String = ""//city_id
     var city:String=""//city
     var locationId:String=""//location_id
    
     init(cityId:String,city:String,locationId:String) {
        self.cityId = cityId
        self.city = city
        self.locationId = locationId
     }
  
}
