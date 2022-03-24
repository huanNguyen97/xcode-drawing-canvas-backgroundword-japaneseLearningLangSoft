//
//  Canvas.swift
//  Canvas-Drawing
//
//  Created by BSP Macbook on 3/24/22.
//

import Foundation

import UIKit

// New class canvas for build drawing
class Canvas: UIView {
    
    // Canvas adding
    // public function to read Undo function
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    // End func
    
    // public function to read Clear function
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    // End func
    
    // Declare the line to show
    var lines = [[CGPoint]]()
    // End declaring
    
    // Declare w - h for pointing
    var x1: Double
    var y1: Double
    var x2: Double
    var y2: Double
    // End declaring
    
    init(x1: Double, y1: Double, x2: Double, y2: Double) {
        self.x1 = x1
        self.y1 = y1
        self.x2 = x2
        self.y2 = y2
        
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
        
        // Custom display of lines
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(20)
        context.setLineCap(.butt)
        // End customing
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
        
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
    
    // Start adding when touch it
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    // End starting
    
    // Track the finger when moving
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Declare co-ordinate
        guard let point = touches.first?.location(in: nil) else { return }
        // End declaring
        
        // Add point into line
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        // End Adding
        
        // Add lastline into biggest array
        lines.append(lastLine)
        // End adding
        
        setNeedsDisplay()
    }
    // End tracking
    
    // When user stop touching
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let lastDrawing = lines[lines.count - 1]
        
        print(lastDrawing[0].x, lastDrawing[0].y)
        print(lastDrawing[lastDrawing.count - 1].x, lastDrawing[lastDrawing.count - 1].y)
        
        if !(
            (
                (self.x1 - 20) ... (self.x1 + 20) ~= Double(lastDrawing[0].x)
                    && (self.y1 - 20) ... (self.y2 + 20) ~= Double(lastDrawing[0].y)
            ) &&
            (
                (self.x2 - 20) ... (self.x2 + 20) ~= Double(lastDrawing[lastDrawing.count - 1].x)
                    && (self.y2 - 20) ... (self.y2 + 20) ~= Double(lastDrawing[lastDrawing.count - 1].y)
            )
        ) {
            undo()
        }
    }
    // End touch
}
// End class
