//
//  TextSnippitViewController.swift
//  Snippit
//
//  Created by Lee Herbst on 9/10/17.
//  Copyright © 2017 Lee Herbst. All rights reserved.
//

import Foundation
import UIKit
class TextSnippitViewController: UIViewController, UITextViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
    }
    
    
}

extension TextSnippitViewController{
    
    func textViewDidEndEditing(_ textView: UITextView) {
    
    }
}
