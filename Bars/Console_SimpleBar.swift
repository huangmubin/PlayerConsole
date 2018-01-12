//
//  Console_SimpleBar.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/10.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation


import UIKit

extension PlayerConsole {
    
    class Bar_Simple: PlayerConsole.Bar {
        
        // MARK: - Deploy
        
        override func deploy_init(to console: PlayerConsole) {
            has_play_button = false
            has_full_button = false
            has_backward_button = false
            has_forward_button = false
            has_screenshot_button = false
            has_back_button = false
            
            progress.type = .point
            
            super.deploy_init(to: console)
            insertSubview(background, at: 0)
            background.layer.cornerRadius = 8
            background.backgroundColor = background_color
            background.alpha = background_alpha
            
            labels.update(color: UIColor.lightGray)
            labels.update(font: UIFont.systemFont(ofSize: UIFont.buttonFontSize - 6, weight: UIFont.Weight.light))
        }
        
        override func deploy_frame(with rect: CGRect) {
            super.deploy_frame(with: rect)
            background.frame = CGRect(
                x: 2,
                y: rect.height - (is_showing ? 32 : -30),
                width: rect.width - 4,
                height: 30
            )
            labels.current.frame = CGRect(
                x: background.frame.minX,
                y: background.frame.minY,
                width: 42,
                height: background.frame.height
            )
            labels.total.frame = CGRect(
                x: background.frame.maxX - 42,
                y: background.frame.minY,
                width: 42,
                height: background.frame.height
            )
            progress.deploy_frame(with: CGRect(
                x: labels.current.frame.maxX,
                y: background.frame.origin.y,
                width: labels.total.frame.minX - labels.current.frame.maxX,
                height: background.frame.height
            ))
            touch.deploy_frame(with: CGRect(
                x: 0,
                y: 30,
                width: bounds.width,
                height: bounds.height - 60
            ))
        }
        
        // MARK: - Touch
        
        override func player_console_touch_action() {
            buttons.play_action()
        }
        
        // MARK: - Background
        
        /** Bar Background */
        private var background: UIView = UIView()
        
        override func update_background_color() {
            background.backgroundColor = background_color
        }
        
        override func update_background_alpha() {
            background.alpha = background_alpha
        }
        
    }
    
}
