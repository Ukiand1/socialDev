//
//  ViewController.swift
//  SocialDev
//
//  Created by Uroš Đurđević on 20/09/16.
//  Copyright © 2016 Uroš Đurđević. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignVC: UIViewController {

    @IBOutlet weak var emailField: PrittyField!
    @IBOutlet weak var pwdField: PrittyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.stringForKey(KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }


    @IBAction func facebookBtnTapped(_ sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("UROS: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print ("UROS: User cancelled Facebook authentication")
            } else {
                print ("UROS: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print ("UROS: Unable to authenticate with Firebase - \(error)")
            } else {
                print ("UROS: Successfully authenticated with Firebase")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
                
            }
        })
    }
    
    @IBAction func signInTapped(_ sender: AnyObject) {
    
        if let email = emailField.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print ("UROS: Email user authenticated with Firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print ("UROS: Email user FAILED auth with Firebase")
                        } else {
                            print ("UROS: Successfully auth with Firebase")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                    
                }
            })
        }
        
    }
    
    
    func completeSignIn(id: String){
        let keychainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        print("UROS: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }

}

