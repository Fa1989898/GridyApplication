//
//  PuzzleViewController.swift
//  GridyApplication
//
//  Created by Fatima Zakaria on 20/11/2019.
//  Copyright © 2019 Fatima Salhi. All rights reserved.
////

import UIKit

class PuzzleViewController: UIViewController {
    
    
    public var puzzleImage: UIImage?
    public var gridDimension = 4
    
    
    
    @IBOutlet weak var cView1: UICollectionView!
    
    @IBOutlet weak var cView2: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

