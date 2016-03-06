//
//  SuspectCell.swift
//  DwabitSecurity
//
//  Created by Kelvin Lau on 2016-03-06.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import UIKit

final class SuspectCell: UICollectionViewCell {
    @IBOutlet var tableView: UITableView! { didSet {
        tableView.dataSource = self
        tableView.delegate = self
    }}
}

extension SuspectCell: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? IncidentCell else { fatalError() }
        switch indexPath.row {
        case 0:
            cell.incidentImageView.image = UIImage(named: "court-order")
            cell.incidentLabel.text = "Retraining Order"
            cell.dateLabel.text = "January 26, 2010"
        case 1:
            cell.incidentImageView.image = UIImage(named: "physical-abuse")
            cell.incidentLabel.text = "Physical Abuse"
            cell.dateLabel.text = "Feburary 4, 2012"
        case 2:
            cell.incidentImageView.image = UIImage(named: "verbal")
            cell.incidentLabel.text = "Verbal Abuse"
            cell.dateLabel.text = "March 4, 2012"
        default:
            break
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}

extension SuspectCell: UITableViewDelegate {
    
}