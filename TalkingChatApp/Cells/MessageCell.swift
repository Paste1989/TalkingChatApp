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

        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormater = ISO8601DateFormatter()
        let chatDate = isoFormater.date(from: isoDate.appending("Z"))
        
        let newFormater = DateFormatter()
        newFormater.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormater.string(from: finalDate)
            timeStampLabel.text = finalDate
        } 
    }
}
