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
    
    
    //Variables
    var avatarType = AvatarType.dark
    
    
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarPickerCollectionViewCell", for: indexPath) as? avatarPickerCollectionViewCell {
            
            cell.configureCell(index: indexPath.item, type: avatarType)
            
            return cell
        }
        
        return avatarPickerCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }
        else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numOfColumns = 4
        }
        
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        
        let cellDimension = ((avatarPickerCollectionView.bounds.size.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    
    @IBAction func darkLightControlPressed(_ sender: Any) {
//        if avatarType == AvatarType.dark {
//            avatarType = AvatarType.light
//        }
//        else {
//            avatarType = AvatarType.dark
//        }
        
        if darkLightSegmentedControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        }
        else {
            avatarType = .light
        }
        avatarPickerCollectionView.reloadData()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
