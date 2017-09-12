//
//  ViewController.swift
//  Snippit
//
//  Created by Lee Herbst on 9/8/17.
//  Copyright © 2017 Lee Herbst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var data: [SnippitData] = [SnippitData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func createNewSnippit(_ sender: Any) {
        let alert = UIAlertController(title: "Select a Snippit type", message: nil, preferredStyle: .actionSheet )
        
        let textAction = UIAlertAction(title: "Text", style: .default, handler:
        {
            (_ alert: UIAlertAction) -> Void in
            self.createNewTextSnippit()
        })
        
        let photoAction = UIAlertAction(title: "Photo", style: .default, handler:
        {
            (_ alert: UIAlertAction) -> Void in
            self.data.append(SnippitData(sType: SnippitType.photo))
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(textAction)
        alert.addAction(photoAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func createNewTextSnippit () {
        guard let textEntryVC = storyboard?.instantiateViewController(withIdentifier: "textSnippitEntry") as? TextSnippitEntryViewController else {
            print("TextSnippitEntryViewController could not be instantiated from storyboard")
            return
        }
        textEntryVC.modalTransitionStyle = .coverVertical
        textEntryVC.saveText = { (text: String) in
            let newTextSnippet = TextData(text: text)
            self.data.append(newTextSnippet)
        }
        present(textEntryVC, animated: true, completion: nil)
    }
    


}

