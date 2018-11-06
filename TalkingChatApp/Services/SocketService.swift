//
//  SocketService.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 24.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit
import SocketIO

var socket: SocketIOClient!

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
   
    //var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    
    
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    lazy var socket = manager.defaultSocket
    
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else  { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    
    func getChatMessage(completion: @escaping CompletionHandler) {
        socket.on("messageCreated") { (bodyArray, ack) in
            
            guard let msgBody = bodyArray[0] as? String else { return }
            guard let channelId = bodyArray[2] as? String else { return }
            guard let userName = bodyArray[3] as? String else { return }
            guard let userAvatar = bodyArray[4] as? String else { return }
            guard let userAvatarColor = bodyArray[5] as? String else { return }
            guard let id = bodyArray[6] as? String else { return }
            guard let timeStamp = bodyArray[7] as? String else { return }
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                
                let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                
                completion(true)
            }
            else {
                completion(false)
            }
        }
    }
}
