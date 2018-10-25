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
        
        socket.emit("channelName", channelName, channelDescription)
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

}
