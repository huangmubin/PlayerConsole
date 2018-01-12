//
//  PlayerConsole_Resource.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension PlayerConsole {
    /** Player Console Image Resource */
    class Resource { }
}

extension PlayerConsole.Resource {
    
    static let play: UIImage? = {
        var image: UIImage?
        let path = UIBezierPath()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 40, height: 40), false, 0)
        path.move(to: CGPoint(x: 5, y: 5))
        path.addLine(to: CGPoint(x: 5, y: 35))
        path.addLine(to: CGPoint(x: 35, y: 20))
        path.close()
        UIColor.white.setFill()
        path.fill()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }()
    
    static let stop: UIImage? = {
        var image: UIImage?
        let path = UIBezierPath()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 40, height: 40), false, 0)
        path.move(to: CGPoint(x: 5, y: 5))
        path.addLine(to: CGPoint(x: 5, y: 35))
        path.addLine(to: CGPoint(x: 18, y: 35))
        path.addLine(to: CGPoint(x: 18, y: 5))
        path.close()
        
        path.move(to: CGPoint(x: 22, y: 5))
        path.addLine(to: CGPoint(x: 22, y: 35))
        path.addLine(to: CGPoint(x: 35, y: 35))
        path.addLine(to: CGPoint(x: 35, y: 5))
        path.close()
        
        UIColor.white.setFill()
        path.fill()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }()
    
    static let full: UIImage? = {
        var image: UIImage?
        let path = UIBezierPath()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 40, height: 40), false, 0)
        path.move(to: CGPoint(x: 5, y: 20))
        path.addLine(to: CGPoint(x: 5, y: 35))
        path.addLine(to: CGPoint(x: 20, y: 35))
        path.addLine(to: CGPoint(x: 20, y: 33))
        path.addLine(to: CGPoint(x: 8.5, y: 33))
        path.addLine(to: CGPoint(x: 19.5, y: 22))
        path.addLine(to: CGPoint(x: 18, y: 20.5))
        path.addLine(to: CGPoint(x: 7, y: 31.5))
        path.addLine(to: CGPoint(x: 7, y: 20))
        path.close()
        
        path.move(to: CGPoint(x: 20, y: 5))
        path.addLine(to: CGPoint(x: 20, y: 7))
        path.addLine(to: CGPoint(x: 31.5, y: 7))
        path.addLine(to: CGPoint(x: 20.5, y: 18))
        path.addLine(to: CGPoint(x: 22, y: 19.5))
        path.addLine(to: CGPoint(x: 33, y: 8.5))
        path.addLine(to: CGPoint(x: 33, y: 20))
        path.addLine(to: CGPoint(x: 35, y: 20))
        path.addLine(to: CGPoint(x: 35, y: 5))
        path.close()
        
        UIColor.white.setFill()
        path.fill()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }()
    
    static let unfull: UIImage? = {
        var image: UIImage?
        let path = UIBezierPath()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 40, height: 40), false, 0)
        path.move(to: CGPoint(x: 4, y: 22))
        path.addLine(to: CGPoint(x: 4, y: 23))
        path.addLine(to: CGPoint(x: 15.5, y: 23))
        path.addLine(to: CGPoint(x: 4.5, y: 34))
        path.addLine(to: CGPoint(x: 6, y: 35.5))
        path.addLine(to: CGPoint(x: 17, y: 23.5))
        path.addLine(to: CGPoint(x: 17, y: 36))
        path.addLine(to: CGPoint(x: 19, y: 36))
        path.addLine(to: CGPoint(x: 19, y: 21))
        path.close()
        
        path.move(to: CGPoint(x: 21, y: 4))
        path.addLine(to: CGPoint(x: 21, y: 19))
        path.addLine(to: CGPoint(x: 36, y: 19))
        path.addLine(to: CGPoint(x: 36, y: 17))
        path.addLine(to: CGPoint(x: 24.5, y: 17))
        path.addLine(to: CGPoint(x: 35.5, y: 6))
        path.addLine(to: CGPoint(x: 34, y: 4.5))
        path.addLine(to: CGPoint(x: 23, y: 15.5))
        path.addLine(to: CGPoint(x: 23, y: 4))
        path.close()
        
        UIColor.white.setFill()
        path.fill()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }()
    
    class func image(_ name: String) -> UIImage? {
        if let path = Bundle.main.path(forResource: "Console", ofType: "bundle") {
            if let bundle = Bundle(path: path) {
                if let path = bundle.path(forResource: "console_" + name, ofType: "png") {
                    if let image = UIImage(contentsOfFile: path) {
                        return image
                    }
                }
            }
        }
        switch "name" {
        case "play":
            return PlayerConsole.Resource.play
        case "stop":
            return PlayerConsole.Resource.stop
        case "full":
            return PlayerConsole.Resource.full
        case "unfull":
            return PlayerConsole.Resource.unfull
        default: return nil
        }
    }
    
}
