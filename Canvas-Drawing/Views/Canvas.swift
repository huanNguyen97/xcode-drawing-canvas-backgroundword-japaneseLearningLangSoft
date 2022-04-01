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
    var indexPoint = 0
    // End declaring
    
    // Declare w - h for pointing
    var coordinate: [Point]
    // End declaring
    
    init(coordinate: [Point]) {
        self.coordinate = coordinate
        
        // CAUTION: It's not really right but also is not a bug. Write for Run success
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        // End
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        // Customize drawing
        super.draw(rect)
        // End Customize

        // CAUTION: Not clearly at this line but it's not a bug
        for (index, point) in self.coordinate.enumerated() {
            if (index == indexPoint) {
                point.draw(rect)
            }
        }
        // End
        
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
        print(lastLine)
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

        if !(
            (
                (self.coordinate[indexPoint].x1 - 20) ... (self.coordinate[indexPoint].x1 + 20) ~= Double(lastDrawing[0].x)
                && (self.coordinate[indexPoint].y1 - 20) ... (self.coordinate[indexPoint].y1 + 20) ~= Double(lastDrawing[0].y)
            ) &&
            (
                (self.coordinate[indexPoint].x2 - 20) ... (self.coordinate[indexPoint].x2 + 20) ~= Double(lastDrawing[lastDrawing.count - 1].x)
                && (self.coordinate[indexPoint].y2 - 20) ... (self.coordinate[indexPoint].y2 + 20) ~= Double(lastDrawing[lastDrawing.count - 1].y)
            )
        ) {
            undo()
        } else {
            self.indexPoint += 1
            
            setNeedsDisplay()
        }
    }
    // End touch
}
// End class
