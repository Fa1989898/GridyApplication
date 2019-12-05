//
//  SelectedImageViewController.swift
//  GridyApplication
//
//  Created by Fatima Zakaria on 11/11/2019.
//  Copyright © 2019 Fatima Salhi. All rights reserved.
//



import UIKit

class SelectedImageViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var pickedImageView: UIImageView!
    
    
    
    public var selectedImage: UIImage?
    public var gridDimension = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configure()
    }
    
    private func updateUI() {
        if let selectedImage = selectedImage {
            DispatchQueue.main.async {
                UIView.animate(
                    withDuration: 1,
                    animations: {
                        let backgroundImageView = UIImageView.init(frame: self.view.frame)
                        backgroundImageView.image = selectedImage
                        let currentFilter = CIFilter(name:"CIGaussianBlur")
                        let beginImage = CIImage(image: backgroundImageView.image!)
                        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
                        currentFilter!.setValue(10, forKey: kCIInputRadiusKey)
                        
                        let cropFilter = CIFilter(name: "CICrop")
                        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
                        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
                        
                        //let output = cropFilter!.outputImage
                        //                        let cgimg = self.context.createCGImage(output!, from: output!.extent)
                        //                        let processedImage = UIImage(cgImage: cgimg!)
                        //                        backgroundImageView.image = processedImage
                        //                        backgroundImageView.contentMode = .scaleAspectFill
                        //                        self.view.insertSubview(backgroundImageView, at: 0)
                } ,
                    completion: nil
                )
            }
            pickedImageView.image = selectedImage
        }
    }
    
    
    @IBAction func selectedImagePressed(sender: Any) {
        self.performSegue(withIdentifier: "puzzleImage", sender: self)
    }

    
    func configure() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeImage(_:)))
        tapGestureRecognizer.delegate = self
        pickedImageView.addGestureRecognizer(tapGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveImageView(_:)))
        panGestureRecognizer.delegate = self
        pickedImageView.addGestureRecognizer(panGestureRecognizer)
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotateImageView(_:)))
        rotationGestureRecognizer.delegate = self
        pickedImageView.addGestureRecognizer(rotationGestureRecognizer)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(scaleImageView(_:)))
        pinchGestureRecognizer.delegate = self
        pickedImageView.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    
    @objc func changeImage(_ sender: UITapGestureRecognizer) {
        print("changing")
    }
    
    @objc func moveImageView(_ sender: UIPanGestureRecognizer) {
        print("moving")
    }
    
    @objc func rotateImageView(_ sender: UIRotationGestureRecognizer) {
        print("rotating")
    }
    
    @objc func scaleImageView(_ sender: UIPinchGestureRecognizer) {
        print("scaling")
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            
            // simultaneous gesture recognition will only be supported for creationImageView
            if gestureRecognizer.view != pickedImageView {
                return false
            }
            
            // neither of the recognized gestures should not be tap gesture
            if gestureRecognizer is UITapGestureRecognizer
                || otherGestureRecognizer is UITapGestureRecognizer
                || gestureRecognizer is UIPanGestureRecognizer
                || otherGestureRecognizer is UIPanGestureRecognizer {
                return false
            }
            
            return true
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "puzzleImage" {
            let destinationVC = segue.destination as! PuzzleViewController
            destinationVC.puzzleImage = selectedImage
            destinationVC.gridDimension = gridDimension
        }
    }
    
 
    
    
}
