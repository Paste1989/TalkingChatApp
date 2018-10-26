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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    
    //Variables
    var avatarName = "profIcon"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    
    
    //MAK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Actions
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let name = userNameTextField.text , userNameTextField.text != nil else {return}
        guard let email = emailTextField.text , emailTextField.text != nil else {return}
        guard let pass = passwordTextField.text , passwordTextField.text != nil else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("USER REGISTERED!")
                
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    
                    if success {
                        print("USER LOGGED IN!")
                        
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: "\(self.avatarColor)", completion: { (success) in
                            
                            print(name, email, self.avatarName, self.avatarColor)
                            
                            if success {
                                print("USER CREATED!",
                                      "avatarName: \(UserDataService.instance.avatarName)",
                                    "avatarColor: \(UserDataService.instance.avatarColor)")
                                
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                            else {
                                print("USER IS NOT CRETAED")
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func choseImageBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBGColorBtnPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform((255))) / 255
        let g = CGFloat(arc4random_uniform((255))) / 255
        let b = CGFloat(arc4random_uniform((255))) / 255
       
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.2) {
            self.userImage.backgroundColor = self.bgColor
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    
    func setupView() {
        spinner.isHidden = true
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: myPurple])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: myPurple])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: myPurple])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
}
