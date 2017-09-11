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
        textView.inputAccessoryView = createKeyboardToolbar()
        textView.becomeFirstResponder()
    }


    //MARK: UITextViewDelegate
    func textViewDidEndEditing(_ textView: UITextView){}
    
    
    func createKeyboardToolbar() -> UIView {
        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        keyboardToolbar.setItems([flexSpace, doneButton], animated: false)
        
        return keyboardToolbar
    }
    
    func doneButtonPressed(){
        textView.resignFirstResponder
    }

}

