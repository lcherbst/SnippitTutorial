//
//  TextSnippitEntryViewController.swift
//  Snippit
//
//  Created by Lee Herbst on 9/8/17.
//  Copyright © 2017 Lee Herbst. All rights reserved.
//

import Foundation
import UIKit
class TextSnippitEntryViewController: UIViewController, UITextViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        textView.delegate = self
        textView.becomeFirstResponder()
    }


    //MARK: UITextViewDelegate
    func textViewDidEndEditing(_ textView: UITextView){}

}

