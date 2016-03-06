//
//  DistressCollectionViewController.swift
//  DwabitSecurity
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

final class DistressCollectionViewController: UICollectionViewController {
    private let ref = Firebase(url: "https://dwabit.firebaseio.com/DistressSignals")
    
    private let imageRef = Firebase(url: "https://dwabit.firebaseio.com/DistressImages")
    
    private var data = [DistressSignal]() { didSet {
        collectionView?.reloadSections(NSIndexSet(index: 0))
    }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            self.data = snapshot.children.map { DistressSignal(snapshot: $0 as! FDataSnapshot) }
        }, withCancelBlock: { error in
            print("Error: \(error)")
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController as! DetailViewController
        destinationViewController.distressImageRef = imageRef.childByAppendingPath(sender as! String)
    }
}

// MARK: - UICollectionViewDataSource
extension DistressCollectionViewController {
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as? DistressCell else { fatalError() }
        let distressSignal = data[indexPath.row]
        cell.nameLabel.text = "\(distressSignal.name), \(distressSignal.latitude), \(distressSignal.longitude)"
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}

// MARK: - UICollectionViewDelegate
extension DistressCollectionViewController {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailSegue", sender: data[indexPath.row].name)
    }
}