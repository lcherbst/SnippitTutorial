//
//  ViewController.swift
//  Snippit
//
//  Created by Lee Herbst on 9/8/17.
//  Copyright © 2017 Lee Herbst. All rights reserved.
//

import UIKit
import CoreLocation
import Social
import CoreData

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    //MARK: Properties
    var data: [NSManagedObject] = [NSManagedObject]()
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
        reloadSnippitData()
        tableView.reloadData()
    }
    
    func reloadSnippitData () {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = delegate.managedObjectContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Snippit")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let fetchResults = try managedContext.fetch(request)
            self.data = fetchResults as! [NSManagedObject]
        } catch {
            let e = error as NSError
            print("Unresolved error \(e), \(e.userInfo)")
        }
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
           self.saveTextSnippit(text: text)
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
    
    func saveTextSnippit(text: String) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = delegate.managedObjectContext
        let desc = NSEntityDescription.entity(forEntityName: "TextSnippit", in: managedContext)
        let textSnippit = NSManagedObject(entity: desc!, insertInto: managedContext)
        textSnippit.setValue(SnippitType.text.rawValue, forKey: "type")
        textSnippit.setValue(text, forKey: "text")
        textSnippit.setValue(NSDate(), forKey: "date")
        if let coord = self.currentCoordinate {
            textSnippit.setValue(coord.latitude, forKey: "latitude")
            textSnippit.setValue(coord.longitude, forKey: "longitude")
        }
        delegate.saveContext()
    }
    
    func savePhotoSnippet(photo: UIImage) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = delegate.managedObjectContext
        let desc = NSEntityDescription.entity(forEntityName: "PhotoSnippit", in: managedContext)
        let photoSnippit = NSManagedObject(entity: desc!, insertInto: managedContext)
        let photoData = UIImagePNGRepresentation(photo)
        photoSnippit.setValue(SnippitType.photo.rawValue, forKey: "type")
        photoSnippit.setValue(photoData, forKey: "photo")
        photoSnippit.setValue(NSDate(), forKey: "date")
        if let coord = self.currentCoordinate {
            photoSnippit.setValue(coord.latitude, forKey: "latitude")
            photoSnippit.setValue(coord.longitude, forKey: "longitude")
        }
        delegate.saveContext()    }
    
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
        
        savePhotoSnippet(photo: image)
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
      
        let snippitData = data[indexPath.row]
        let snippitDate = snippitData.value(forKey: "date") as! Date
        let snippitType = SnippitType(rawValue: snippitData.value(forKey: "type") as! String)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyy hh:mm:ss a"
        let dateString = formatter.string(from: snippitDate)
        switch snippitType
        {
        case .text:
            let snippitText = snippitData.value(forKey: "text") as! String
            cell = tableView.dequeueReusableCell(withIdentifier: "textSnippitCell", for: indexPath) as! TextSnippitCell
            (cell as! TextSnippitCell).label.text = snippitText
            (cell as! TextSnippitCell).date.text = dateString
            
            (cell as! TextSnippitCell).shareButton = {
                //Code to handle sharing to facebook - need to use share sheet? Social links deprecated.
            }
        case .photo:
            let snippitPhoto = UIImage(data: snippitData.value(forKey: "photo") as! Data)
            cell = tableView.dequeueReusableCell(withIdentifier: "photoSnippitCell", for: indexPath)
            (cell as! PhotoSnippitCell).photo.image = snippitPhoto
            (cell as! PhotoSnippitCell).date.text = dateString
        
            (cell as! PhotoSnippitCell).shareButton = {
                //Code to handle sharing to facebook - need to use share sheet? Social links deprecated.
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = delegate.managedObjectContext
        let currentObject = data[indexPath.row]
        managedContext.delete(currentObject)
        delegate.saveContext()
        reloadSnippitData()
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
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

