//
//  AvatarPickerVC.swift
//  TalkingChatApp
//
//  Created by Saša Brezovac on 17.10.2018..
//  Copyright © 2018. CopyPaste89. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    //MARK: - Outlets
    @IBOutlet weak var avatarPickerCollectionView: UICollectionView!
    @IBOutlet weak var darkLightSegmentedControl: UISegmentedControl!
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarPickerCollectionView.delegate = self
        avatarPickerCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Actions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarPickerCollectionViewCell", for: indexPath)
        
        
        return cell
    }
    
    
    @IBAction func darkLightControlPressed(_ sender: Any) {
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
