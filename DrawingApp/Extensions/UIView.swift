//
//  UIView.swift
//  DrawingApp
//
//  Created by Yauheni Bunas on 6/4/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SwiftUI

extension UIView {
    func takeScreenShoot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            return image!
        }
        
        return UIImage()
    }
}
