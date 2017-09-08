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
        let newSnippit: SnippitData = SnippitData()
        data.append(newSnippit)
    }

}

