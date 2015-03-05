//
//  LimSignatureView.swift
//  SwiftSignatureView
//
//  Created by MyAdmin on 3/6/15.
//  Copyright (c) 2015 MyAdmin. All rights reserved.
//

import UIKit

class LimSignatureView: UIView {

    
    var beizerPath: UIBezierPath = UIBezierPath()
    var incrImage : UIImage?
    var points : [CGPoint] = Array<CGPoint>(count: 5, repeatedValue: CGPointZero)
    var control : Int = 0
    
    var lblSignature : UILabel = UILabel()
    var shapeLayer :   CAShapeLayer?
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        incrImage?.drawInRect(rect)
        beizerPath.stroke()
        
        // Set initial color for drawing
        
        UIColor.redColor().setFill()
        UIColor.redColor().setStroke()
        beizerPath.stroke()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var lblHeight: CGFloat = 61.0
        self.backgroundColor = UIColor.blackColor()
        beizerPath.lineWidth = 2.0
        lblSignature.frame = CGRectMake(0, self.frame.size.height/2 - lblHeight/2, self.frame.size.width, lblHeight);
        lblSignature.font = UIFont (name: "HelveticaNeue-UltraLight", size: 30)
        lblSignature.text = "Sign Here";
        lblSignature.textColor = UIColor.lightGrayColor()
        lblSignature.textAlignment = NSTextAlignment.Center
        lblSignature.alpha = 0.3;
        self.addSubview(lblSignature)
    }

    
    // MARK : - TOUCH Implementation
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {

        if lblSignature.superview != nil {
            lblSignature.removeFromSuperview()
        }
        
        control = 0;
        var touch = touches.anyObject() as UITouch
        points[0] = touch.locationInView(self)
        
        var startPoint = points[0];
        var endPoint = CGPointMake(startPoint.x + 1.5, startPoint.y
            + 2);
        
        beizerPath.moveToPoint(startPoint)
        beizerPath.addLineToPoint(endPoint)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        var touch = touches.anyObject() as UITouch
        var touchPoint = touch.locationInView(self)
        control++;
        points[control] = touchPoint;
        
        if (control == 4)
        {
            points[3] = CGPointMake((points[2].x + points[4].x)/2.0, (points[2].y + points[4].y)/2.0);
            beizerPath.moveToPoint(points[0])
            beizerPath.addCurveToPoint(points[3], controlPoint1: points[1], controlPoint2: points[2])
            
            self.setNeedsDisplay()
            
            points[0] = points[3];
            points[1] = points[4];
            control = 1;
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        self.drawBitmapImage()
        self.setNeedsDisplay()
        
        beizerPath.removeAllPoints()
        control = 0
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        self.touchesEnded(touches, withEvent: event)
    }
    
    // MARK : LOGIC
    
    func drawBitmapImage() {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0);
        
        if incrImage != nil {
            var rectpath = UIBezierPath(rect: self.bounds)
            UIColor.clearColor().setFill()
            rectpath.fill()
        }
        incrImage?.drawAtPoint(CGPointZero)
        
        //Set final color for drawing
        UIColor.redColor().setStroke()
        beizerPath.stroke()
        
        incrImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
