//
//  CanSignal.swift
//  CanGatewayApp
//
//  Created by Emanuele Garolla on 02/10/17.
//  Copyright © 2017 Emanuele Garolla. All rights reserved.
//

import Foundation

class Word {
    
    private(set) var word : String
    private(set) var meaning : String
    private(set) var count: Int
    
    init(word w: String, meaning m: String, count c: Int ) {
        word = w
        meaning = m
        count = c
    }
}
