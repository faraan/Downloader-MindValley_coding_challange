//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 23/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//


import UIKit
import AVFoundation

class PhotoStreamViewController: UICollectionViewController {
    
    var photos = [Photo]()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        callPinboardAPI()
        initiateRefreshData()
    }
    
    // Adding Referesh control
    func initiateRefreshData() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing ...")
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(refreshOptions(sender:)),
                                 for: .valueChanged)
        self.collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        callPinboardAPI()
        sender.endRefreshing()
    }
    
    
    // API call to fetch all data
    func callPinboardAPI(){
        
        StaticHelper.shared.showActivity(text: .kLoading)
        
        APIHelper.shared.getRequest(urlString: .kBaseUrl) { (isSuccess, result) in
            
            StaticHelper.shared.hideActivity()
            
            if isSuccess{
                
                if let data = result as? [[String: Any]]{
                    
                    self.setApiData(data: data)
                    
                    self.collectionView.reloadData()
                }
            }else{
                
                self.alert(message: "API call failed")
            }
        }
        
    }
    
    func setApiData(data: [[String: Any]]){
        
        for details in data{
            var userName = ""
            var imageUrl = ""
            
            if let userDetails = details["user"] as? [String: Any]{
                
                userName = "\(userDetails["name"] ?? "")"
            }
            if let urls = details["urls"] as? [String: Any]{
                
                imageUrl = "\(urls["small"] ?? "")"
            }
            self.photos.append(Photo.init(userName: userName, imageUrl: imageUrl))
        }
    }
}

extension PhotoStreamViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnotatedPhotoCell", for: indexPath)
        if let annotateCell = cell as? AnnotatedPhotoCell {
            annotateCell.photo = photos[indexPath.item]
        }
        return cell
    }
    
}

//MARK: - PINTEREST LAYOUT DELEGATE
extension PhotoStreamViewController : PinterestLayoutDelegate {
    
    // 1. Returns the photo height
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        if let annotateCell = collectionView.cellForItem(at: indexPath) as? AnnotatedPhotoCell {
            return annotateCell.imageView.image!.size.height
        }
        return 250.0
    }
    
}

extension PhotoStreamViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
