//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 23/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//


import UIKit

class AnnotatedPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                imageView.hnk_setImageFromURL(URL.init(string: photo.imageUrl)!)
                userNameLabel.text = photo.userName
            }
        }
    }
    
}
