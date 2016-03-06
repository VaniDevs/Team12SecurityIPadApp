//
//  VictimCell.swift
//  DwabitSecurity
//
//  Created by Kelvin Lau on 2016-03-06.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import UIKit
import MapKit

final class VictimCell: UICollectionViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderAgeLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
}