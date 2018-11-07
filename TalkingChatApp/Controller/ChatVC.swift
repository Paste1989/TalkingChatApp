//
//  ChatVC.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 11.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var isTyping: Bool!
    
    //MARK: - Outlets
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var userTypingLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chatTableView.estimatedRowHeight = 80
        chatTableView.rowHeight = UITableViewAutomaticDimension

        sendButton.isHidden = true
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
     
        view.backgroundColor = UIColor.white
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        
        SocketService.instance.getChatMessage { (newMessage) in
            
            if newMessage.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.chatTableView.reloadData()
                
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.chatTableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            var names = ""
            var numberOfTypers = 0
            
            for (typerUser, channel) in typingUsers {
                if typerUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typerUser
                    }
                    else {
                        names = "\(names), \(typerUser)"
                    }
                    numberOfTypers += 1
                }
            }
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.userTypingLabel.text = "\(names) \(verb) typing a message."
            }
            else {
                self.userTypingLabel.text = ""
            }
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
        
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Actions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
        
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    
    @IBAction func messageTextFieldEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        
        if messageTextField.text?.count == 0 {
            isTyping = false
            sendButton.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        }
        else if (messageTextField.text?.count)! > 0 || messageTextField.becomeFirstResponder() {
            isTyping = true
            sendButton.isHidden = false
            SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
        }
    }
    
    
    @objc func userDataDidChanged(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        }
        else {
            channelNameLabel.text = "Please Log In"
            self.chatTableView.reloadData()
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    

    @IBAction func sendBtnPressed(_ sender: Any) {
        print("SEND BTN PRESSED")
        
        if AuthService.instance.isLoggedIn {
            
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            print("CHANID: \(channelId)")
            guard let message = messageTextField.text else { return }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
                    self.sendButton.isHidden = true
                }
                else {
                    print("Message not sent!")
                }
            })
        }
    }
    
    
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No channels yet!"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { (success) in
            
            if success {
                print("CHAAAA: \(channelId)")
                self.chatTableView.reloadData()
            }
            else {
                print("THERE'S no CHANNNEL")
            }
        }
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLabel.text = "#\(channelName)"
        getMessages()
    }
    
    
}
