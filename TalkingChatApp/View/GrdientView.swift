//
//  GrdientView.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 12.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

        @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.4, green: 0.8039215686, blue: 0.9333333333, alpha: 1) {
            didSet{
                setNeedsLayout()
            }
        }
        
        @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {
            didSet{
                setNeedsLayout()
            }
        }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
