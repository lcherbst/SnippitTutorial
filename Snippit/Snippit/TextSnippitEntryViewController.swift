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
    var saveText: (_ text:String) -> Void = { (text:String) in }
    
    
    //MARK: Overrides
    override func viewDidLoad() {
      super.viewDidLoad()
        textView.delegate = self
        textView.inputAccessoryView = createKeyboardToolbar()
        textView.becomeFirstResponder()
    }

    
    //MARK: Class Methods
    func createKeyboardToolbar() -> UIView {
        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        keyboardToolbar.setItems([flexSpace, doneButton], animated: false)
        
        return keyboardToolbar
    }
    
    func doneButtonPressed(){
        textView.resignFirstResponder()
    }
    
    
    //MARK: UITextViewDelegate Protocols
    func textViewDidEndEditing(_ textView: UITextView) {
        saveText(textView.text)
        dismiss(animated: true, completion: nil)
    }
}

