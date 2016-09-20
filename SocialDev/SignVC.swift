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

class SignVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            }
        })
    }

}

