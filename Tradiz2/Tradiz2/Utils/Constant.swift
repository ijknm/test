//
//  Constant.swift
//  Tradiz2
//
//  Created by JIS on 5/9/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import Foundation

struct Constant {
    
    static let SAVE_ROOT_PATH = "Tradiz"
    
    static let BASE_URL = "https://mexuz.com:8443/Tradiz/api/"
    static let SERVER_URL = "http://www.mexuz.com:8080/Tradiz/api/"
    
    static let REQ_REGISTER = BASE_URL + "Register/"
    static let REQ_UPLOAD = SERVER_URL + "upload/"
    static let REQ_SEARCHKEYWORD = SERVER_URL + "SearchKeywords/"
    
    static let RES_URL = "url"
    
    static let RES_ID = "id"
    static let RES_RELECANCYFACTOR = "RelecancyFactor"
    static let RES_KEYWORD = "Keyword"
    static let RES_KEYWORD2 = "Keyword2"
    
    static let RES_SUCCESS = "Success"
    static let RES_MSG = "Msg"
     /*
     static let RES_QUESTION1 = "question1"
    static let RES_QUESTION2 = "question2"
    static let RES_FILEURL = "file_url"
    
    static let RES_COMMENTS = "comments"
    static let RES_COMMENT = "comment"
    static let RES_REGDATE = "reg_date"
    static let RES_SHARECOUNT = "share_count"
    static let RES_COMMENTCOUNT = "comment_count"
    static let RES_LIKECOUNT = "like_count"
    static let RES_MYLIKETYPE = "my_like_type"
    static let RES_RECENTLIKETYPE = "recent_like_type"
    
    
    static let EMAIL = "email"
    static let PASSWORD = "password"
    */
    static let mainColor = UIColor.init(red: 41, green: 171, blue: 226)

    static let grayColor = UIColor.init(red: 245, green: 245, blue: 245)
    static let darkGrayColor = UIColor.init(red: 200, green: 200, blue: 200)
    static let barTintColor = UIColor.init(red: 60, green: 60, blue: 60)
    
}

