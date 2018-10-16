//
//  RoundedButton.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 16.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import Foundation

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
    
}
