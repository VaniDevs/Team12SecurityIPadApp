//
//  DetailCollectionViewController.swift
//  DwabitSecurity
//
//  Created by Kelvin Lau on 2016-03-06.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import UIKit
import Firebase

final class DetailCollectionViewController: UICollectionViewController {
    private enum Cells: Int {
        case Victim, Suspect
    }
    
    private let infoRef = Firebase(url: "https://dwabit.firebaseio.com/UserInfo")
    private let imageRef = Firebase(url: "https://dwabit.firebaseio.com/DistressImages")
    
    var name: String!
    
    var userInfo: UserInfo? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    var distressImages: [DistressImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: view.frame.width / 2, height: view.frame.width / 2)

        infoRef.childByAppendingPath(name).observeEventType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull {
                fatalError()
            }
            self.userInfo = UserInfo(snapshot: snapshot)
        })
        
        imageRef.childByAppendingPath(name).observeEventType(.ChildAdded, withBlock: { snapshot in
            if snapshot.value is NSNull {
                fatalError()
            }
            self.distressImages = snapshot.children.map { DistressImage(snapshot: $0 as! FDataSnapshot) }
        })
    }
}

// MARK: - UICollectionViewDataSource
extension DetailCollectionViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cellGroup = Cells(rawValue: indexPath.row) else { fatalError() }
        switch cellGroup {
        case .Victim:
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VictimCell", forIndexPath: indexPath) as? VictimCell else { fatalError() }
            if let userInfo = userInfo {
                cell.addressLabel.text = userInfo.address
                cell.nameLabel.text = userInfo.name
                cell.genderAgeLabel.text = "\(userInfo.gender), \(userInfo.age)"
            }
            return cell
        case .Suspect:
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SuspectCell", forIndexPath: indexPath) as? SuspectCell else { fatalError() }
            return cell
        }
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath) as? CustomHeader else { fatalError() }
        return header
    }
}