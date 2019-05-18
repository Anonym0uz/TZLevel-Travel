//
//  AlbumsCollectionCell.swift
//  TZLevel-Travel
//
//  Created by Alexander Orlov on 10.05.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

import UIKit
import SnapKit

class AlbumsCollectionCell: UICollectionViewCell {
    
    var models: NSMutableArray = []
    
    public func updateModel(model: NSMutableArray) {
        self.models = model
        self.cellCollectionView.reloadData()
    }
    
    private let cellID = "ChildCellID"
    
    let cellTitle: UILabel = {
        let lbl = UILabel().setupLabel(text: "Albums", textColor: UIColor.black, parentView: nil)
        return lbl
    }()
    
    let cellCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
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
        
        cellCollectionView.delegate = self
        cellCollectionView.dataSource = self
        cellCollectionView.register(ChildAlbumsCollectionCell.self, forCellWithReuseIdentifier: cellID)
        addSubviews([cellTitle, cellCollectionView])
        
        cellTitle.snp.remakeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(10)
        }
        
        cellCollectionView.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.top.equalTo(self.cellTitle.snp.bottom)
        }
    }
}

extension AlbumsCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.cellCollectionView.scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.cellCollectionView.scrollToNearestVisibleCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChildAlbumsCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChildAlbumsCollectionCell
        cell.updateCell(model: models[indexPath.row] as! iTunesObject)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    
}
