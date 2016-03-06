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
    @IBOutlet private var imageView: UIImageView!
    
    private var data = [DistressImage]() { didSet {
        print(data.count)
        guard let imageString = data.first?.imageString else { fatalError() }
        let decodedData = NSData(base64EncodedString: imageString, options: .IgnoreUnknownCharacters)!
        imageView.image = UIImage(data: decodedData)
    }}
    
    var distressImageRef: Firebase!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(distressImageRef)
        
        distressImageRef.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.children)
            self.data = snapshot.children.map { DistressImage(snapshot: $0 as! FDataSnapshot) }
        })
    }
    
    
}