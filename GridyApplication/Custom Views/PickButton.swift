//
//  PickButton.swift
//  GridyApplication
//
//  Created by Fatima Zakaria on 11/11/2019.
//  Copyright © 2019 Fatima Salhi. All rights reserved.
//


import UIKit

class PickButton: UIButton {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PickButton", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame =  self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layer.cornerRadius = 10
        contentView.isUserInteractionEnabled = false
    }
}

extension PickButton {
    func animatedButtonPressed() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (finished) in
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
}
