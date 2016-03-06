//
//  CustomFooter.swift
//  DwabitSecurity
//
//  Created by Kelvin Lau on 2016-03-06.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import UIKit
import Firebase

final class CustomFooter: UICollectionReusableView {
    private var distressImages = [DistressImage]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet var collectionView: UICollectionView! { didSet {
        collectionView.dataSource = self
        collectionView.delegate = self
    }}
    
    var name: String? { didSet {
        beginWatching()
    }}
    private let imageRef = Firebase(url: "https://dwabit.firebaseio.com/DistressImages")

    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.width / 3)

    }
}

extension CustomFooter: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FooterCell", forIndexPath: indexPath) as? FooterCell else { fatalError() }
        
        let imageString = distressImages[indexPath.row].imageString
        
        let decodedData = NSData(base64EncodedString: imageString, options: .IgnoreUnknownCharacters)
        let decodedimage = UIImage(data: decodedData!)!
        cell.imageView.image = decodedimage
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return distressImages.count
    }
}

extension CustomFooter: UICollectionViewDelegate {
    func beginWatching() {
        imageRef.childByAppendingPath(name).observeEventType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull {
                fatalError()
            }
            self.distressImages = snapshot.children.map { DistressImage(snapshot: $0 as! FDataSnapshot) }
        })
    }
}