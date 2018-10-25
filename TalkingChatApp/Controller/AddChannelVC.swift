//
//  AddChannelVC.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 24.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var channDescriptionTextField: UITextField!
    
    @IBOutlet weak var bgView: UIView!
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: - Actions
    @IBAction func AddChannelBtnPressed(_ sender: Any) {
        guard let channelName = nameTextField.text, nameTextField.text != "" else { return }
        guard let channelDesc = channDescriptionTextField.text, channDescriptionTextField.text != ""  else { return }
        
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupView(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: myPurple])
        channDescriptionTextField.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: myPurple])
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
