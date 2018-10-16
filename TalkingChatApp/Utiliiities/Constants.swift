//
//  Utillities.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 15.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()


// URL Constants
let BASE_URL = "https://talkingchat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"


//Segues
let TO_LOGIN = "toLogin"
let CREATE_AN_ACCOUNT = "create_an_account"
let UNWIND = "unwindToChannel"


//UserDefaults
let TOKEN_KEY = "token"
let IS_LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"






