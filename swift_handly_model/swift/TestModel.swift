//
//  TestModel.swift
//  swift_handly_model
//
//  Created by ydz on 2018/5/2.
//  Copyright © 2018年 yzd. All rights reserved.
//

import UIKit
import HandyJSON

class TestModel: NSObject, HandyJSON {
    
    var user_name : String = ""
    var title : String = ""
    var actionlist : Array<ActionModel>?
    var base : BaseModel?
        
    required override init(){}
}

//子类Model
class BaseModel : NSObject, HandyJSON {
    
    var userprovince : String = ""
    
    required override init(){}
}

class ActionModel : NSObject, HandyJSON {
    
    var aname : String = ""
    
    required override init(){}
}


