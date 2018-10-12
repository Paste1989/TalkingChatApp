//
//  ChatVC.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 11.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var menuButton: UIButton!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
     
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Actions

}
