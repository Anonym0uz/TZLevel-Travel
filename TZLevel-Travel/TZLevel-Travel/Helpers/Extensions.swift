//
//  Extensions.swift
//  TZLevel-Travel
//
//  Created by Alexander Orlov on 07.05.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

import UIKit

extension UILabel {
    func setupLabel(text: String?, textColor: UIColor, parentView: UIView?) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.textColor = textColor
        if parentView != nil { parentView?.addSubview(lbl) }
        return lbl
    }
}

extension UIImageView {
    func setupImageView(clipBounds: Bool, image: String!, parentView: UIView?) -> UIImageView {
        let imgView = UIImageView()
        if image != "" { imgView.image = UIImage(named: image) }
        imgView.clipsToBounds = clipBounds
        imgView.contentMode = .scaleAspectFill
        if parentView != nil { parentView?.addSubview(imgView) }
        return imgView
    }
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        self.image = nil
        contentMode = mode
        let imageCache = NSCache<AnyObject, AnyObject>()
        if let imgFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imgFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                let writeImgToCache = image
                imageCache.setObject(writeImgToCache, forKey: url as AnyObject)
                self.image = writeImgToCache
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIView {
    func setupView(backgroundColor: UIColor, parentView: UIView?) -> UIView {
        let view = UIView()
        if parentView == nil { parentView?.addSubview(view) }
        return view
    }
    
    func addSubviews(_ views: [Any]) {
        views.forEach { self.addSubview($0 as! UIView) }
    }
}

extension UIColor {
    func hexColor(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class CustomTableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cellID")
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() { }
}

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            let distance: Float = fabsf(visibleCenterScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
