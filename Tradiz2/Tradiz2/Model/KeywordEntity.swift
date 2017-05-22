//
//  KeywordEntity.swift
//  Tradiz2
//
//  Created by JIS on 5/18/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import Foundation
import SwiftyJSON

class KeywordEntity : Equatable {
    
    var _id = 0
    var _relecancyFactor = ""
    var _keyword = ""
    var _keyword2 = ""
    var _isSelected = 0
    
    init(){
        
    }
    


    init(dict: JSON) {
    
        _id = Int(dict[Constant.RES_ID].stringValue)!
        _relecancyFactor = dict[Constant.RES_RELECANCYFACTOR].stringValue
        _keyword = dict[Constant.RES_KEYWORD].stringValue
        _keyword2 = dict[Constant.RES_KEYWORD2].stringValue
        
        _isSelected = 0
    }
    
    static func ==(lhs:KeywordEntity, rhs:KeywordEntity) -> Bool { // Implement Equatable
        return lhs._id == rhs._id
    }

}
