//
//  Actor.swift
//  assignment
//
//  Created by Ayush Varshney on 27/11/17.
//  Copyright © 2017 Ayush Varshney. All rights reserved.
//

import UIKit

class Actors: Codable {
    let actors: [Actor]
    
    init(actors: [Actor]) {
        self.actors = actors
    }
}


class Actor: Codable {
    let name: String
    let description: String
    let image: String
    
    init(name: String, description: String, image: String) {
        self.name = name
        self.description = description
        self.image = image
    }
}
