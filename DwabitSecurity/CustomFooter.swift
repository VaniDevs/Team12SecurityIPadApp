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
    
    private let name = "Meyrl"
    private let imageRef = Firebase(url: "https://dwabit.firebaseio.com/DistressImages")

    override func awakeFromNib() {
        super.awakeFromNib()
        imageRef.childByAppendingPath(name).observeEventType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull {
                fatalError()
            }
            self.distressImages = snapshot.children.map { DistressImage(snapshot: $0 as! FDataSnapshot) }
        })
    }
}

extension CustomFooter: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FooterCell", forIndexPath: indexPath) as? FooterCell else { fatalError() }
        
        let imageString = distressImages[indexPath.row].imageString
        
        let decodedData = NSData(base64EncodedString: imageString, options: NSDataBase64DecodingOptions(rawValue: 0))
        let decodedimage = UIImage(data: decodedData!)!
        cell.imageView.image = decodedimage as UIImage
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return distressImages.count
    }
}

extension CustomFooter: UICollectionViewDelegate {
    
}