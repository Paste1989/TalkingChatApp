//
//  LoginVC.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 15.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //MARK: - Outlets
    
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Actions
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
