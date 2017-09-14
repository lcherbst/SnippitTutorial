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
    let date: Date
    
    init(sType: SnippitType, creationDate: Date){
        type = sType
        date = creationDate
        print ("new \(type.rawValue) snippit created on \(date)")
    }
    
}


class TextData: SnippitData {
    let textData: String
    
    init (text: String, creationDate: Date) {
        textData = text
        super.init(sType: .text, creationDate: creationDate)
        print ("Text snippet data: \(textData)")
        
        
    }
}


class PhotoData: SnippitData {
    let photoData: UIImage
    
    init (photo: UIImage, creationDate: Date) {
        photoData = photo
        super.init(sType: .photo, creationDate: creationDate)
        print ("Photo snippet data: \(photoData)")
        
        
    }
}
