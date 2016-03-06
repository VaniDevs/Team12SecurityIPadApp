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
    
    static var caseNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleImageView = UIImageView(image: UIImage(named: "group"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        titleImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        navigationItem.titleView = titleImageView
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: view.frame.width / 3 - 50, height: view.frame.width / 3 - 50)
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            self.data = snapshot.children.map { DistressSignal(snapshot: $0 as! FDataSnapshot) }
        }, withCancelBlock: { error in
            print("Error: \(error)")
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! DetailViewController
        destinationVC.name = sender as! String
        
        print(sender)
    }
}

// MARK: - UICollectionViewDataSource
extension DistressCollectionViewController {
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as? DistressCell else { fatalError() }
        let distressSignal = data[indexPath.row]
        cell.nameLabel.text = "\(distressSignal.name)"
        cell.caseLabel.text = "Case #\(DistressCollectionViewController.caseNumber)"
        cell.callButton.setTitle("Call \(distressSignal.name)", forState: .Normal)
        DistressCollectionViewController.caseNumber += 1
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath)
    }
}

// MARK: - UICollectionViewDelegate
extension DistressCollectionViewController {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowDetail", sender: data[indexPath.row].name)
    }
}