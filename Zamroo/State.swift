//
//  State.swift
//  Zamroo
//
//  Created by Rohit Singh on 27/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class State: NSObject {
    
     var stateId:String = ""//state_id
     var state:String=""//state
     var status:String=""//status

    init(stateId:String,state:String,status:String) {
        self.stateId = stateId
        self.state = state
        self.status = status
        
    }
  
}
