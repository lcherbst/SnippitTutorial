//
//  SnippitData.swift
//  Snippit
//
//  Created by Lee Herbst on 9/8/17.
//  Copyright © 2017 Lee Herbst. All rights reserved.
//
import UIKit

enum SnippitType: String {
    case text = "Text"
    case photo = "Photo"
}


class SnippitData {
    
    let type: SnippitType
    
    init(sType: SnippitType){
        type = sType
        print ("new \(type.rawValue) snippit created")
    }
    
}


class TextData: SnippitData {
    let textData: String
    
    init (text: String) {
        textData = text
        super.init(sType: .text)
        print ("Text snippet data: \(textData)")
        
        
    }
}


class PhotoData: SnippitData {
    let photoData: UIImage
    
    init (photo: UIImage) {
        photoData = photo
        super.init(sType: .photo)
        print ("Photo snippet data: \(photoData)")
        
        
    }
}
