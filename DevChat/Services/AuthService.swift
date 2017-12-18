//
//  AuthService.swift
//  DevChat
//
//  Created by TheAppExperts on 12/18/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    if errorCode == AuthErrorCode.userNotFound {
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                //show error to user
                            } else {
                                if user?.uid != nil {
                                    //sign in
                                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            //show err
                                        } else {
                                            //successfully logged in
                                        }
                                    })
                                }
                            }
                        })
                    }
                } else {
                    //handle all other errors
                }
            } else {
                //sucessfully logged in
            }
        }
    }
}
