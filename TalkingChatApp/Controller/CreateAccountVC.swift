//
//  CreateAccountVC.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 15.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    
    var avatarName = "profIcon"
    var avatarColor = "0.5, 0.5, 0.5, 1"
    
    
    //MAK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Actions
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        
        guard let name = userNameTextField.text , userNameTextField.text != nil else {return}
        guard let email = emailTextField.text , emailTextField.text != nil else {return}
        guard let pass = passwordTextField.text , passwordTextField.text != nil else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("USER IS REGISTERED!")
                
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    
                    if success {
                        print("USER IS LOGGED IN!")
                        
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            
                            if success {
                                print("USER CREATED!",
                                      "avatarName: \(UserDataService.instance.avatarName)",
                                    "avatarColor: \(UserDataService.instance.avatarColor)")
                                
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func choseImageBtnPressed(_ sender: Any) {
    }
    
    @IBAction func generateBGColorBtnPressed(_ sender: Any) {
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
