//
//  MenuCellCell.swift
//  Tradiz2
//
//  Created by JIS on 5/11/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import UIKit

class MenuCellCell: UITableViewCell {

    @IBOutlet weak var imvIcon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ iconPath:String, menuName:String) {
        
        imvIcon.image = UIImage(named: iconPath)
        lblName.text = menuName
    }

}
