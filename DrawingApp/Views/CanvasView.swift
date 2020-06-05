//
//  CanvasView.swift
//  DrawingApp
//
//  Created by Yauheni Bunas on 6/3/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import UIKit

struct TouchPointAndColor {
    var color: UIColor?
    var width: CGFloat?
    var opacity: CGFloat?
    var points: [CGPoint]?
    
    init(color: UIColor, points: [CGPoint]) {
        self.color = color
        self.points = points
    }
}

class CanvasView: UIView {
    
    var lines = [TouchPointAndColor]()
    var strokeWidth: CGFloat = 1.0
    var strokeColor: UIColor = .black
    var strokeOpacity: CGFloat = 1.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        lines.forEach { (line) in
            for (index, point) in (line.points?.enumerated())! {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
                
                context.setStrokeColor(line.color?.withAlphaComponent(line.opacity!).cgColor ?? UIColor.black.cgColor)
                context.setLineWidth(line.width!)
            }
            
            context.setLineCap(.round)
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(TouchPointAndColor(color: UIColor(), points: [CGPoint]()))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first?.location(in: nil) else {
            return
        }
        
        guard var lastPoint = lines.popLast() else {
            return
        }
        
        lastPoint.points?.append(touch)
        lastPoint.color = self.strokeColor
        lastPoint.width = self.strokeWidth
        lastPoint.opacity = self.strokeOpacity
        
        lines.append(lastPoint)
        
        setNeedsDisplay()
    }
    
    func clearCanvasView() {
        lines.removeAll()
        
        setNeedsDisplay()
    }
    
    func undoDraw() {
        if lines.count > 0 {
            lines.removeLast()
            
            setNeedsDisplay()
        }
    }
}
