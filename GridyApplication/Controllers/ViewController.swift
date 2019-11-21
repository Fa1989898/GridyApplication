//
//  ViewController.swift
//  Gridy
//
//  Created by Fatima Zakaria on 11/10/2019.
//  Copyright © 2019 Fatima Salhi. All rights reserved.
//

import UIKit
import Photos
import AVFoundation




class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var pickButton: PickButton!
    @IBOutlet weak var cameraButton: PickButton!
    @IBOutlet weak var libraryButton: PickButton!
    
    
    
    private var pickedImage: UIImage?
    
    private let localImages: [UIImage] = [UIImage(named: "Butterfly")!, UIImage(named: "Fox")!, UIImage(named: "Grizzly")!, UIImage(named: "Macao")!, UIImage(named: "Rhinoceros")!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeButtons()
    }
    
    private func customizeButtons() {
        pickButton.mainLabel.text = "Pick"
        pickButton.mainImage.image = UIImage(named: "Gridy-name-small-grey")
        
        libraryButton.mainLabel.text = "Library"
        libraryButton.mainImage.image = UIImage(named: "Gridy-library")
        
        cameraButton.mainLabel.text = "Camera"
        cameraButton.mainImage.image = UIImage(named: "Gridy-camera")
        
    }
    
    
    
    @IBAction func cameraButtonPressed(_ sender: AnyObject) {
        cameraButton.animatedButtonPressed()
        print("Camera")
        takeAPhoto()
        displayCamera()
    }
    
    
    @IBAction func libraryButtonPressed(_ sender: AnyObject) {
        libraryButton.animatedButtonPressed()
        print("Library")
        displayLibrary()
    }
    
    
    
    func takeAPhoto(){
        let alertController = UIAlertController(title: "Take a photo", message: nil, preferredStyle: .alert)
        
        //take a photo action
        let takePhoto = UIAlertAction(title: "Ok", style: .default) { (action) in
            print("Take a photo action")
        }
        
        //add picking action to alert controller
        alertController.addAction(takePhoto)
        
        // create cancel action
        let cancelPhotoAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Canceling photo taking")
        }
        
        // add cancel action to alert controller
        alertController.addAction(cancelPhotoAction)
        
        present(alertController, animated: true) {
            // code to execute after the controller finished presenting
        }
        
    }
    
    
    
    func displayLibrary() {
        let sourceType = UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let status = PHPhotoLibrary.authorizationStatus()
            let noPermissionMessage = "Gridy doesn't have access to libary"
            
            switch status {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (newStatus) in
                    if newStatus == .authorized {
                        self.presentImagePicker(sourceType: sourceType)
                    } else {
                        self.troubleAlert(message: noPermissionMessage)
                    }
                })
            case .authorized:
                self.presentImagePicker(sourceType: sourceType)
            case .denied, .restricted:
                self.troubleAlert(message: noPermissionMessage)
            @unknown default:
                fatalError("authorised status not handled")
            }
        }
        else {
            troubleAlert(message: "Access to photo library denied to Gridy")
        }
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if newStatus == .authorized {
                    print("granted - present image picker!")
                } else {
                    print("denied")
                }
            })
        case .authorized:
            print("granted - present image picker!")
        case .denied, .restricted:
            print("denied")
        @unknown default:
            fatalError("case not handled")
        }
    }
    
    
    func presentImagePicker(sourceType: UIImagePickerController.SourceType){
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func troubleAlert(message: String?) {
        let alertController = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
    func displayCamera() {
        print("Launching device camera")
        let sourceType = UIImagePickerController.SourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            
            let noPermissionMessage = "Gridy doesn't have access to your camera. Please use Setting app on your device to permit Gridy accessing your camera"
            
            switch status {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                    if granted {
                        self.presentImagePicker(sourceType: sourceType)
                    } else {
                        self.troubleAlert(message: noPermissionMessage)
                    }
                })
            case .authorized:
                self.presentImagePicker(sourceType: sourceType)
            case .denied, .restricted:
                self.troubleAlert(message: noPermissionMessage)
            @unknown default:
                fatalError("Request acess not handled")
            }
        }
        else {
            troubleAlert(message: "Access denied")
        }
    }
    
    
    
    
    @IBAction func pickButtonPressed(_ sender: Any) {
        let randomIndex = Int.random(in: 0..<localImages.count)
        pickedImage = localImages[randomIndex]
        self.performSegue(withIdentifier: "selectedImage", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "selectedImage" {
                    let destinationVC = segue.destination as! SelectedImageViewController
                    destinationVC.selectedImage = pickedImage
    }
    }
    
    
}
