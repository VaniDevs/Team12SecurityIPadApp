//
//  DistressImage.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import UIKit
import Firebase

struct DistressImage {
    let imageString: String
    
    init(image: UIImage) {
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else { fatalError() }
        let base64String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength) as String
        self.imageString = base64String
    }
    
    init(snapshot: FDataSnapshot) {
        imageString = snapshot.value["image"] as! String
    }
}