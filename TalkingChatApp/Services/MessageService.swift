//
//  ChannelService.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 18.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
    
    
            if response.result.error == nil {
                guard let data = response.data else { return }
                
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                }
//                catch let error {
//                    debugPrint(error)
//                }

                if let json = try! JSON(data: data).array {

                    for item in json {
                        let id = item["id"].stringValue
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue

                        let channel = Channel(channelTitle: name, channelDescription: description, id: id)

                        self.channels.append(channel)
                    }
                    print(self.channels)
                    completion(true)
                }
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
