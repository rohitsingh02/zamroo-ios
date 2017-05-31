//
//  TopCity.swift
//  Zamroo
//
//  Created by Rohit Singh on 27/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class TopCity: NSObject {
    fileprivate var cityId:String = ""//city_id
    fileprivate var cityName:String = ""//city_name
    
    var _cityId : String {
        set { self.cityId = newValue }
        get { return self.cityId}
    }
    var _city: String {
        set { self.cityName = newValue }
        get { return self.cityName  }
    }
  
}
