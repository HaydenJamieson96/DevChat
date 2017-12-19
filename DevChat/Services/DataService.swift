//
//  DataService.swift
//  DevChat
//
//  Created by TheAppExperts on 12/19/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService {
    
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    //Ref to app database
    var mainRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef: DatabaseReference {
        return mainRef.child("users")
    }
    
    var mainStorageRef: StorageReference {
        return Storage.storage().reference(forURL: "gs://devchat-41422.appspot.com")
    }
    
    var imagesStorageRef: StorageReference {
        return mainStorageRef.child("images")
    }
    
    var videoStorageRef: StorageReference {
        return mainStorageRef.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, Any> = ["firstName": "", "lastName": ""]
        mainRef.child("users").child(uid).child("profile").setValue(profile)
    }
    
    func sendMediaPullRequest(senderUID: String, sendingTo: Dictionary<String, User>, mediaURL: URL, textSnippet: String? = nil) {
        var uids = [String]()
        for uid in sendingTo.keys {
            uids.append(uid)
        }
        var pr: Dictionary<String, Any> = ["mediaURL" : mediaURL.absoluteString, "userID" : senderUID, "openCount" : 0, "recipients" : uids]
        mainRef.child("pullRequests").childByAutoId().setValue(pr)
        
        
    }
    
    
    
}
