//
//  LocationInfo.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import CoreLocation
import UIKit
import Firebase

struct DistressSignal {
    let longitude: Double
    let latitude: Double
    let name: String
    
    init(coordinates: CLLocationCoordinate2D, name: String) {
        longitude = coordinates.longitude
        latitude = coordinates.latitude
        self.name = name
    }
    
    init(snapshot: FDataSnapshot) {
        name = snapshot.value["name"] as! String
        guard let latitude = snapshot.value["latitude"] as? NSNumber else { fatalError() }
        guard let longitude = snapshot.value["longitude"] as? NSNumber else { fatalError() }
        
        self.latitude = latitude.doubleValue
        self.longitude = longitude.doubleValue
    }
    
    func toJson() -> NSDictionary {
        return [
            "longitude": "\(longitude)",
            "latitude": "\(latitude)",
            "name": "\(name)"
        ]
    }
}