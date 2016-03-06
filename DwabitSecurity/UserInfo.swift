//
//  UserInfo.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import Foundation
import Firebase

struct UserInfo {
    let name: String
    let age: String
    let gender: String
    let phone: String
    let sin: String
    let address: String
    
    init(snapshot: FDataSnapshot) {
        name = snapshot.value["name"] as! String
        age = snapshot.value["age"] as! String
        gender = snapshot.value["gender"] as! String
        phone = snapshot.value["phone"] as! String
        sin = snapshot.value["sin"] as! String
        address = snapshot.value["address"] as! String
    }
    
    init(name: String, age: String, gender: String, phone: String, sin: String, address: String) {
        self.name = name
        self.age = age
        self.gender = gender
        self.phone = phone
        self.sin = sin
        self.address = address
    }
    
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