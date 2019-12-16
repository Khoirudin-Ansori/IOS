//
//  Admins.swift
//  iosapp
//
//  Created by Dwicky Fauza on 12/5/19.
//  Copyright © 2019 IOSLOSS. All rights reserved.
//

import Foundation
class Admins{
    var userid: Int = 0
    var username: String = ""
    var password: String = ""
    
    init(userid:Int, username:String, password:String) {
        self.userid = userid
        self.username = username
        self.password = password
    }
}
