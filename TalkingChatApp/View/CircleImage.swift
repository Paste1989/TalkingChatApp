//
//  CircleImage.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 17.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import Foundation

@IBDesignable
class CircleImage: UIImageView {
    
    override func awakeFromNib() {
       setUpView()
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    
    func setUpView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
