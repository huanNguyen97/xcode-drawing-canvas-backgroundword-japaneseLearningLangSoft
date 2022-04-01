//
//  Point.swift
//  Canvas-Drawing
//
//  Created by BSP Macbook on 3/26/22.
//

import Foundation
import UIKit

class Point: UIView {
    
    // static let screenSize: CGRect = UIScreen.main.bounds
    // let screenWidth = Int(screenSize.width)
    // let screenHeight = Int(screenSize.height)
    // let screenWidth: Double = {
        // return Double(screenSize.width)
    // }()
    
    // Declare w - h for pointing
    var x1: Double
    var y1: Double
    var x2: Double
    var y2: Double
    // End declaring
    
    init(x1: Double, y1: Double, x2: Double, y2: Double) {
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        // Iphone XR, Iphone Xs Max, Iphone 11, Iphone 11 Pro Max
        if (screenSize.width == 414.0 && screenSize.height == 896.0) {
            self.x1 = x1
            self.y1 = y1
            self.x2 = x2
            self.y2 = y2
        }// Iphone 11 Pro, X, Xs
        else if (screenSize.width == 375.0 && screenSize.height == 812.0) {
            self.x1 = x1 - (39 / 2)
            self.y1 = y1 - (84 / 2)
            self.x2 = x2 - (39 / 2)
            self.y2 = y2 - (84 / 2)
        } // Iphone 6+, 6s+, 7+, 8+
        else if (screenSize.width == 414.0 && screenSize.height == 736.0) {
            self.x1 = x1
            self.y1 = y1 - (160 / 2)
            self.x2 = x2
            self.y2 = y2 - (160 / 2)
        } // Iphone 6, 6s, 7, 8
        else if (screenSize.width == 375.0 && screenSize.height == 667) {
            self.x1 = x1 - (39 / 2)
            self.y1 = y1 - (229 / 2)
            self.x2 = x2 - (39 / 2)
            self.y2 = y2 - (229 / 2)
        } // The others
        else {
            self.x1 = x1
            self.y1 = y1
            self.x2 = x2
            self.y2 = y2
        }

        
        // CAUTION: Not clearly at this line but it's not a bug
        super.init(frame: CGRect(x: self.x1 + self.x2, y: self.y1 + self.y2, width: 2, height: 2))
        // End caution
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        // Customize drawing
        super.draw(rect)
        // End Customize
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Point 1 - startPoint
        let rectangle1 = CGRect(x: self.x1, y: self.y1, width: 2, height: 2)
        
        context.setFillColor(UIColor.systemRed.cgColor)
        context.setStrokeColor(UIColor.systemRed.cgColor)
        context.setLineWidth(20)
        context.addRect(rectangle1)
        context.drawPath(using: .fillStroke)
        // End point
        
        // Point 2 - endPoint
        let rectangle2 = CGRect(x: self.x2, y: self.y2, width: 2, height: 2)

        context.setFillColor(UIColor.systemGreen.cgColor)
        context.setStrokeColor(UIColor.systemGreen.cgColor)
        context.setLineWidth(20)
        context.addRect(rectangle2)
        context.drawPath(using: .fillStroke)
        // End point
    }
}
