//
//  ImageCollectionViewCell.swift
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 26/02/24.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    static let identifier = "ImageCollectionViewCell"
    
    
    @IBOutlet weak var imageVw: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageVw.contentMode = .scaleAspectFill
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }

}
