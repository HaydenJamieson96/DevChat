//
//  DataService.swift
//  DevChat
//
//  Created by TheAppExperts on 12/19/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataService {
    
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    //Ref to app database
    var mainRef: DatabaseReference {
        return Database.database().reference()
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, Any> = ["firstName": "", "lastName": ""]
        mainRef.child("users").child(uid).child("profile").setValue(profile)
    }
    
}
