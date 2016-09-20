//
//  FeedVC.swift
//  SocialDev
//
//  Created by Uroš Đurđević on 20/09/16.
//  Copyright © 2016 Uroš Đurđević. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signedInTapped(_ sender: AnyObject) {
        let keychainResult = KeychainWrapper.removeObjectForKey(KEY_UID)
        print ("UROS: ID removed from keychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
