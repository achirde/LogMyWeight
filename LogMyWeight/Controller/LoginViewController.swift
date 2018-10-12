//
//  LoginViewController.swift
//  LogMyWeight
//
//  Created by Arkadipra De on 10/3/18.
//  Copyright © 2018 Achirangshu. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var signedUserName: UILabel!
    var loggedInUser : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @IBAction func customGIDButtonPressed(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        print("<><><><><> Signout Button Pressed <><><><><>")
//        do{
//            try Auth.auth().signOut()
//            print("VC Signed Out")
//        }catch let signOutError as NSError {
//            print("VC Error while sign out,\(signOutError)")
//        }
        GIDSignIn.sharedInstance().disconnect()
        GIDSignIn.sharedInstance().signOut()

    }
    
//    func updateUI(){
//
//        print("*******ViewLoad Triggered********")
//
//        if let user = Auth.auth().currentUser?.displayName{
//            print("***********USER***********\(user)")
//            signedUserName.text = user
//
//            //performSegue(withIdentifier: "goToLog", sender: nil)
//        }else{
//            signedUserName.text = "Not logged in"
//        }
//    }
    
    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            print("Error while signing",error)
//            return
//        }else{
//
//        }
//
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//
//        Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
//            if error != nil {
//                print("Error in Firebase Sign in")
//            }else{
//                print(Auth.auth().currentUser?.displayName)
//                self.performSegue(withIdentifier: "goToLog", sender: nil)
//
//            }
//        }
//
//    }
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//        do{
//            try Auth.auth().signOut()
//            print("Signed Out")
//        }catch{
//            print("Error while sign out,\(error)")
//        }
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        //updateUI()
//    }
    
}
