//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 23/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//


import UIKit

struct Photo {
    
    var userName: String
    var imageUrl: String
    var image: UIImage
    
    init(userName: String, imageUrl: String) {
        self.userName = userName
        self.imageUrl = imageUrl
        self.image = UIImage()
    }
    
    
}
