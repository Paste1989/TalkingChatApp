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
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

       self.revealViewController().rearViewRevealWidth =  self.view.frame.size.width - 60
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Actions

}
