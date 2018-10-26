//
//  Grocery.swift
//  Shopping List Helper
//
//  Created by Matthew Krager on 10/24/18.
//  Copyright © 2018 Matthew Krager. All rights reserved.
//

import UIKit


// A Model Object
class Grocery: NSObject {
    
    var name: String
    var price: String
    var quantity: String
    
    init(name: String, price: String, quantity: String) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
    
}
