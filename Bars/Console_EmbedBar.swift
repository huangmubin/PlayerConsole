//
//  Console_EmbedBar.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension PlayerConsole {
    
    class Bar_Embed: PlayerConsole.Bar {
        
        // MARK: - Deploy
        
        override func deploy_init(to console: PlayerConsole) {
            has_play_button = true
            has_full_button = true
            has_backward_button = false
            has_forward_button = false
            has_screenshot_button = false
            
            super.deploy_init(to: console)
            insertSubview(background, at: 0)
            background.layer.cornerRadius = 8
            background.backgroundColor = background_color
            background.alpha = background_alpha
        }
        
        override func deploy_frame(with rect: CGRect) {
            super.deploy_frame(with: rect)
            background.frame = CGRect(
                x: 2,
                y: rect.height - (is_showing ? 62 : 0),
                width: rect.width - 4,
                height: 60
            )
            buttons.play.frame = CGRect(
                x: background.frame.minX,
                y: background.frame.minY,
                width: background.frame.height * (has_play_button ? 1 : 0),
                height: background.frame.height
            )
            buttons.full.frame = CGRect(
                x: background.frame.maxX - background.frame.height,
                y: background.frame.minY,
                width: background.frame.height * (has_full_button ? 1 : 0),
                height: background.frame.height
            )
            labels.current.frame = CGRect(
                x: buttons.play.frame.maxX,
                y: background.frame.minY,
                width: 60,
                height: background.frame.height
            )
            labels.total.frame = CGRect(
                x: buttons.full.frame.minX - 60,
                y: background.frame.minY,
                width: 60,
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
                y: 60,
                width: bounds.width,
                height: bounds.height - 120
            ))
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
        
        // MARK: - Touch
        
        override func player_console_touch_action() {
            if buttons.play.isSelected {
                if is_showing {
                    console?.timer.hide_bar(in: 0)
                } else {
                    animation(show: true)
                    console?.timer.hide_bar(in: 5)
                }
            } else {
                buttons.play_action()
            }
        }
    }
    
}
