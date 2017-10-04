//
//  ViewController.swift
//  Snippit
//
//  Created by Lee Herbst on 9/8/17.
//  Copyright © 2017 Lee Herbst. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    //MARK: Properties
    var data: [SnippitData] = [SnippitData]()
    var currentCoordinate: CLLocationCoordinate2D?
    let imagePicker = UIImagePickerController()
    let locationManager = CLLocationManager()
    @IBOutlet weak var tableView: UITableView!

    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50.0
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        askForLocationPermissions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: Actions
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
            self.createNewPhotoSnippit()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(textAction)
        alert.addAction(photoAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: Class Methods
    func createNewTextSnippit () {
        guard let textEntryVC = storyboard?.instantiateViewController(withIdentifier: "textSnippitEntry") as? TextSnippitEntryViewController else {
            print("TextSnippitEntryViewController could not be instantiated from storyboard")
            return
        }
        textEntryVC.modalTransitionStyle = .coverVertical
        textEntryVC.saveText = { (text: String) in
            let newTextSnippet = TextData(text: text, creationDate: Date(), creationCoordinate: self.currentCoordinate)
            self.data.append(newTextSnippet)
        }
        present(textEntryVC, animated: true, completion: nil)
    }
    
    func createNewPhotoSnippit() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera is not available")
            return
        }
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func askForLocationPermissions () {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //MARK: UIImagePickerControllerDelegate Protocols
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("Image could not be found")
            return
        }
        
        let newPhotoSnippit = PhotoData(photo: image, creationDate: Date(), creationCoordinate: self.currentCoordinate)
        self.data.append(newPhotoSnippit)
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: UITableViewDataSource Protocols
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let sortedData = data.reversed() as [SnippitData]
        let snippitData = sortedData[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyy hh:mm:ss a"
        let dateString = formatter.string(from: snippitData.date)
        switch snippitData.type
        {
        case .text:
            cell = tableView.dequeueReusableCell(withIdentifier: "textSnippitCell", for: indexPath)
            (cell as! TextSnippitCell).label.text = (snippitData as! TextData).textData
            (cell as! TextSnippitCell).date.text = dateString
        case .photo:
            cell = tableView.dequeueReusableCell(withIdentifier: "photoSnippitCell", for: indexPath)
            (cell as! PhotoSnippitCell).photo.image = (snippitData as! PhotoData).photoData
            (cell as! PhotoSnippitCell).date.text = dateString        }
        
        
        return cell
    }
    
    //MARK: CLLocationManagerDelegate Protocols
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager could not get location. Error: \(error.localizedDescription)")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            currentCoordinate = currentLocation.coordinate
            
        }
    }


}

