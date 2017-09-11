//
//  SnippitData.swift
//  Snippit
//
//  Created by Lee Herbst on 9/8/17.
//  Copyright © 2017 Lee Herbst. All rights reserved.
//

class SnippitData {
    
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


class TextData: SnippitData {
    let textData: String
    
    init (text: String) {
        textData = text
        super.init(sType: .text)
        print ("Text snippet data: \(textData)")
        
        
    }
}
