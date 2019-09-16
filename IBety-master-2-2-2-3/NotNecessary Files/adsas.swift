//
//  adsas.swift
//  IBety
//
//  Created by Mohamed on 7/1/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class adsas: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate{
    
    
    var itemsPerRow:CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20.0,
                                     left: 20.0,
                                     bottom: 20.0,
                                     right: 20.0)
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        if let image = UIImage(named: "image\(indexPath.section)\(indexPath.row)")
        {cell.imageView!.image = image}
                let frame = cell.introductionLabel.frame
                cell.introductionLabel.sizeToFit()
                cell.frame.size.height = cell.introductionLabel.frame.size.height+200
                collectionView.reloadData()
        return cell
    }

}
extension adsas{

        //1

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            //2
                return CGSize(width: (self.collectionView.bounds.width / 2) - 20, height: self.view.bounds.width / 2)
        }

        //3
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
        }

        // 4
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return sectionInsets.left
        }


    }
