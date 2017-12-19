//
//  User.swift
//  DevChat
//
//  Created by TheAppExperts on 12/19/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

import Foundation

struct User {
    private var _firstName: String
    private var _uid: String
    
    var uid: String {
        return _uid
    }
    
    var firstName: String {
        return _firstName
    }
    
    init(uid: String, firstName: String) {
        _uid = uid
        _firstName = firstName
    }
}
