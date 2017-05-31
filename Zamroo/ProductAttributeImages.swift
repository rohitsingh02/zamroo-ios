//
//  ProductAttributeImages.swift
//  Zamroo
//
//  Created by Rohit Singh on 27/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class ProductAttributeImages: NSObject {
    fileprivate var image:String = ""//image
    
    var _image : String {
        set { self.image = newValue }
        get { return self.image}
    }
}
