//
//  JobListCell.swift
//  Tradiz2
//
//  Created by JIS on 5/15/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit

class JobListCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.masksToBounds = false;
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 5.0
    }

    
}
