//
//  DetailViewController.swift
//  DwabitSecurity
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import UIKit
import Firebase

final class DetailViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView! { didSet {
        collectionView.delegate = self
        collectionView.dataSource = self
    }}
    
    private let infoRef = Firebase(url: "https://dwabit.firebaseio.com/UserInfo")
    
    var name: String!
    
    var userInfo: UserInfo? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    var distressImages: [DistressImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoRef.childByAppendingPath(name).observeEventType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull {
                fatalError()
            }
            self.userInfo = UserInfo(snapshot: snapshot)
        })

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: collectionView.frame.width / 2.1, height: collectionView.frame.width / 1.1)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    private enum Cells: Int {
        case Victim, Suspect
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cellGroup = Cells(rawValue: indexPath.row) else { fatalError() }
        switch cellGroup {
        case .Victim:
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VictimCell", forIndexPath: indexPath) as? VictimCell else { fatalError() }
            if let userInfo = userInfo {
                cell.addressLabel.text = userInfo.address
                cell.nameLabel.text = userInfo.name
                cell.genderAgeLabel.text = "\(userInfo.gender), \(userInfo.age)"
                cell.mapView.setCenterCoordinate(<#T##coordinate: CLLocationCoordinate2D##CLLocationCoordinate2D#>, animated: <#T##Bool#>)
            }
            return cell
        case .Suspect:
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SuspectCell", forIndexPath: indexPath) as? SuspectCell else { fatalError() }
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "Footer", forIndexPath: indexPath) as? CustomFooter else { fatalError() }
        footer.name = name
        return footer
    }
}

extension DetailViewController: UICollectionViewDelegate {
    
}