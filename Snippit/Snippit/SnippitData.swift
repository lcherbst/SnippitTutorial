//
//  SnippitData.swift
//  Snippit
//
//  Created by Lee Herbst on 9/8/17.
//  Copyright © 2017 Lee Herbst. All rights reserved.
//
import UIKit
import CoreLocation
enum SnippitType: String {
    case text = "Text"
    case photo = "Photo"
}


class SnippitData {
    
    let type: SnippitType
    let date: Date
    let coordinate: CLLocationCoordinate2D?
    
    init(sType: SnippitType, creationDate: Date, creationCoordinate: CLLocationCoordinate2D? ){
        type = sType
        date = creationDate
        coordinate = creationCoordinate
        print ("new \(type.rawValue) snippit created on \(date) at \(coordinate.debugDescription)")
    }
    
}


class TextData: SnippitData {
    let textData: String
    
    init (text: String, creationDate: Date, creationCoordinate: CLLocationCoordinate2D?) {
        textData = text
        super.init(sType: .text, creationDate: creationDate, creationCoordinate: creationCoordinate )
        print ("Text snippet data: \(textData)")
        
        
    }
}


class PhotoData: SnippitData {
    let photoData: UIImage
    
    init (photo: UIImage, creationDate: Date, creationCoordinate: CLLocationCoordinate2D?) {
        photoData = photo
        super.init(sType: .photo, creationDate: creationDate, creationCoordinate: creationCoordinate)
        print ("Photo snippet data: \(photoData)")
        
        
    }
}
