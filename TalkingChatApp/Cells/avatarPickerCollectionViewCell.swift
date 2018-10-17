//
//  avatarPickerCollectionViewCell.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 17.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit

class avatarPickerCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    
    //MARK: - Actions
    func setUpView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
}
