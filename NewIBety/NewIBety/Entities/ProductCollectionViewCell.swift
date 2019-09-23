//
//  ProductCollectionViewCell.swift
//  IBety
//
//  Created by Mohamed on 6/27/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introductionLabel: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
  //  var collectionView:UICollectionView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
}


import UIKit

class NotificationCell:UITableViewCell{
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellBody: UITextView!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var createdTime: UILabel!
    
    
//    init() {
//
//        self.layer.cornerRadius = 10
//        self.layer.shadowPath = self.createRectangle()
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func draw(_ rect: CGRect) {
        
        if let view = self.viewWithTag(120){
            
            view.layer.cornerRadius = 8
            view.layer.shadowPath = view.createRectangle()
        }
        
    }
}

class MYPARTSCollectionViewCell: UICollectionViewCell{
    
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func draw(_ rect: CGRect) {

        path = UIBezierPath.init(rect: self.bounds)
        // Specify the fill color and apply it to the path.
        //        UIColor.orange.setFill()
        //        path.fill()
        
        // Specify a border (stroke) color.
        UIColor.white.setStroke()
        path.stroke()
        
        self.layer.shadowOpacity=0.2
        
    }
}
