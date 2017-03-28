//
//  List.swift
//  Magpie
//
//  Created by Donny Kurniawan on 28/3/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Foundation

class List: NSObject {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    convenience override init() {
        self.init(title: "")
    }
}
