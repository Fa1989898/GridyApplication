//
//  PuzzleViewController.swift
//  GridyApplication
//
//  Created by Fatima Zakaria on 20/11/2019.
//  Copyright © 2019 Fatima Salhi. All rights reserved.
////

import UIKit

class PuzzleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    
    
    @IBOutlet weak var cView1: UICollectionView!
    
    @IBOutlet weak var cView2: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let puzzleImage = puzzleImage {
            print("main image width: \(puzzleImage.size.width) and height: \(puzzleImage.size.height)")
            let imageDict = puzzleImage.splitImage(4).shuffled()
            var images = [UIImage]()
            for i in imageDict {
                images.append(i.value)
                print("image width: \(i.value.size.width) and height: \(i.value.size.height)")
            }
        }
        
        
    }
}

//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if (collectionView == cView2){
//            return 10
//        }
//        
//        return 4
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = cView1.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
//        cell.backgroundColor = UIColor.red
//        if (collectionView == cView2){
//            let cell2 = cView2.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as!  CollectionViewCell2
//            cell2.backgroundColor = UIColor.blue
//            return cell2
//        }
//        return cell
//    }
//}
