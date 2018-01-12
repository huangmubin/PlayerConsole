//
//  Console_Background.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit


extension PlayerConsole {
    class Background: Views {
        var thumbnail: UIImageView = UIImageView()
        
        override func deploy_init(to console: PlayerConsole) {
            super.deploy_init(to: console)
            thumbnail.frame = bounds
            thumbnail.contentMode = .scaleAspectFit
            addSubview(thumbnail)
        }
        
        override func deploy_frame(with rect: CGRect) {
            super.deploy_frame(with: rect)
            thumbnail.frame = bounds
        }
    }
}

