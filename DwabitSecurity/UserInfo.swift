//
//  UserInfo.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import Foundation

struct UserInfo {
    let name: String
    let age: String
    let gender: String
    let phone: String
    let sin: String
    let address: String
    
    func toJson() -> NSDictionary {
        return [
            "name": name,
            "age": age,
            "gender": gender,
            "phone": phone,
            "sin": sin,
            "address": address
        ]
    }
}