//
//  AuthService.swift
//  DevChat
//
//  Created by TheAppExperts on 12/18/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

typealias Completion = (_ errMsg: String?, _ data: Any?) -> Void

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: @escaping Completion) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    if errorCode == AuthErrorCode.userNotFound {
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                            } else {
                                if user?.uid != nil {
                                    DataService.instance.saveUser(uid: user!.uid)
                                    //sign in
                                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                                        } else {
                                            onComplete(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                    }
                } else {
                    //handle all other errors
                    self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                }
            } else {
                //sucessfully logged in
                onComplete(nil, user)
            }
        }
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completion) {
        print(error.debugDescription)
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            switch (errorCode) {
            case .invalidEmail:
                onComplete("Invalid email address", nil)
                break
            case .wrongPassword:
                onComplete("Invalid password",nil)
                break
            case .emailAlreadyInUse, .accountExistsWithDifferentCredential:
                onComplete("Could not create any account, email already in use", nil)
                break
            default:
                onComplete("There was a problem authenticating, Try again", nil)
                
            }
        }
    }
}
