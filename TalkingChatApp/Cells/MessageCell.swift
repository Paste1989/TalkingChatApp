//
//  MessageCell.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 05.11.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: - Actions
    func configureCell(message: Message){
        messageLabel.text = message.message
         userNameLabel.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returUIColor(components: message.userAvatarColor)
//        timeStampLabel.text = 
       
    }
}
