//
//  LginVC.swift
//  FBIntegration
//
//  Created by Brain Tech on 10/01/2020 Saka.
//  Copyright © 1942 Brain Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LginVC: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//                    self.navigationController?.pushViewController(vc, animated: true)
                    self.getFBUserData()
                    
                }
            }
        }
    }
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let vc = self.storyboard!.instantiateViewController(identifier: "HomeVC") as! HomeVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    //everything works print the user data
                    print(result as Any)
                }
            })
        }
    }
}
