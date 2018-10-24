//
//  avatarPickerCollectionViewCell.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 17.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit

enum  AvatarType {
    case dark
    case light
}

class AvatarPickerCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    
    //MARK: - Actions
    func configureCell(index: Int, type: AvatarType){
        if type == AvatarType.dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else {
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setUpView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
}
