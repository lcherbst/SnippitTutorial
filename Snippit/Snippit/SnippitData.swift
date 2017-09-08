//
//  SnippitData.swift
//  Snippit
//
//  Created by Lee Herbst on 9/8/17.
//  Copyright © 2017 Lee Herbst. All rights reserved.
//

struct SnippitData {
    
    let type: SnippitType
    
    init(sType: SnippitType){
        type = sType
        print ("new \(type.rawValue) snippit created")
    }
    
}

enum SnippitType: String {
    case text = "Text"
    case photo = "Photo"
}
