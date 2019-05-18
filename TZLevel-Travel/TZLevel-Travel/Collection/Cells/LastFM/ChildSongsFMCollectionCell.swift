//
//  ChildSongsFMCollectionCell.swift
//  TZLevel-Travel
//
//  Created by Alexander Orlov on 10.05.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

import UIKit
import SnapKit

protocol ChildSongsFMCellDelegate {
    func updateCell(model: LastFMTrack)
}

class ChildSongsFMCollectionCell: UICollectionViewCell, ChildSongsFMCellDelegate {
    
    var delegate: ChildSongsFMCellDelegate?
    
    func updateCell(model: LastFMTrack) {
        
        self.cellTitle.text = model.name
        self.cellSubtitle.text = model.artist
        
        if let sizeOffset = model.image!.index(where: {$0.size == "large"}) {
            // do something with fooOffset
            self.cellImage.downloaded(from: model.image![sizeOffset].text!, contentMode: .scaleAspectFill)
        } else {
            self.cellImage.downloaded(from: model.image![0].text!, contentMode: .scaleAspectFill)
            // item could not be found
        }
        //        if img.count != 0 { self.cellImage.image = UIImage(named: img) }
        //        self.cellTitle.text = title
    }
    
    private var cellImage: UIImageView = {
        let img = UIImageView().setupImageView(clipBounds: true, image: "", parentView: nil)
        return img
    }()
    
    private var cellTitle: UILabel = {
        let lbl = UILabel().setupLabel(text: "", textColor: UIColor.black, parentView: nil)
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()
    
    private var cellSubtitle: UILabel = {
        let lbl = UILabel().setupLabel(text: "", textColor: UIColor.black, parentView: nil)
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.createViewElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViewElements() {
        backgroundColor = UIColor.clear
        
        addSubviews([cellImage, cellTitle, cellSubtitle])
        
        cellImage.snp.remakeConstraints { (make) in
            make.left.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(self.contentView)
        }
        
        cellTitle.snp.remakeConstraints { (make) in
            make.left.equalTo(cellImage.snp.right).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            //            make.top.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView).offset(-7)
        }
        
        cellSubtitle.snp.remakeConstraints { (make) in
            make.left.equalTo(cellImage.snp.right).offset(10)
            make.top.equalTo(cellTitle.snp.bottom)
            make.right.equalTo(self.contentView).offset(-10)
            //            make.centerY.equalTo(self.contentView).offset(10)
        }
    }
}
