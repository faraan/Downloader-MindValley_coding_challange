//
//  StaticHelper.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 23/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Foundation


class StaticHelper: NSObject {
    
    static let shared = StaticHelper()
   
    
    ///*******************************************************
    // MARK: - Activity indicator methods
    ///*******************************************************
    
    
    func showActivity(text: String){
        
        let sizeValue = (40.0/375.0) * UIScreen.main.bounds.size.width
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(size:  CGSize(width: sizeValue, height: sizeValue), message: text, messageFont: UIFont.systemFont(ofSize: 16.0), type: .ballClipRotatePulse, color: .white, padding: 0.0, displayTimeThreshold: 0, minimumDisplayTime: 0), nil)
        
    }
    
    func hideActivity(){
        
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }

    
    //MARK: -Get Main Window
    
    func mainWindow() -> UIWindow {
        let app = UIApplication.shared.delegate as? AppDelegate
        return (app?.window!)!
    }

    
}

