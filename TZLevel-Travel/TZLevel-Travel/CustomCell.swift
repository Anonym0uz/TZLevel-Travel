//
//  CustomCell.swift
//  TZLevel-Travel
//
//  Created by Alexander Orlov on 07.05.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

import UIKit
import SnapKit

class CustomCell: CustomTableCell {
    
    var cellImage: UIImageView!
    var cellTitle: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func createView() {
        cellImage = UIImageView().setupImageView(clipBounds: true, image: "", parentView: self.contentView)
        cellTitle = UILabel().setupLabel(text: "", textColor: UIColor.black, parentView: self.contentView)
        
        cellImage.snp.remakeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.left.equalTo(self.contentView).offset(10)
        }
        
        cellTitle.snp.remakeConstraints { (make) in
            make.left.equalTo(self.cellImage.snp.right).offset(10)
            make.top.equalTo(self.contentView).offset(5)
            make.right.equalTo(self.contentView).offset(-10)
        }
    }

}
