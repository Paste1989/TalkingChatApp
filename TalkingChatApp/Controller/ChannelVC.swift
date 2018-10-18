//
//  ChannelVC.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 11.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImage: CircleImage!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth =  self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Actions
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN , sender: nil)
    }
    
    @objc func userDataDidChanged(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returUIColor(components: UserDataService.instance.avatarColor)
        }
        else {
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "profileDefault")
            userImage.backgroundColor = UIColor.clear
        }
    }
}
