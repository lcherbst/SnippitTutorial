//
//  TextSnippitCell.swift
//  Snippit
//
//  Created by Lee Herbst on 9/14/17.
//  Copyright © 2017 Lee Herbst. All rights reserved.
//

import Foundation
import UIKit

class TextSnippitCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var shareButton: (() -> Void)?
    
    @IBAction func shareButtonPressed() {
        if let callback = shareButton {
            callback()
        }
    }
}
