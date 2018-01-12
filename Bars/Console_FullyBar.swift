//
//  Console_FullyBar.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension PlayerConsole {
    class Bar_Fully: PlayerConsole.Bar {
        
        // MARK: - Deploy
        
        override func deploy_init(to console: PlayerConsole) {
            auto_hide = false
            progress.type = .point
            
            has_play_button = true
            has_full_button = true
            has_backward_button = true
            has_forward_button = true
            has_screenshot_button = true
            has_back_button = true
            
            super.deploy_init(to: console)
            
            insertSubview(background, at: 0)
            background.layer.cornerRadius = 16
            background.backgroundColor = background_color
            background.alpha = background_alpha
            
            insertSubview(background_top_left, at: 0)
            background_top_left.layer.cornerRadius = 16
            background_top_left.backgroundColor = background_color
            background_top_left.alpha = background_alpha
            
            insertSubview(background_top_right, at: 0)
            background_top_right.layer.cornerRadius = 16
            background_top_right.backgroundColor = background_color
            background_top_right.alpha = background_alpha
            
            
            labels.update(color: UIColor.lightGray)
            labels.update(font: UIFont.systemFont(ofSize: UIFont.buttonFontSize - 4, weight: UIFont.Weight.light))
            
            touch.image_view.isHidden = true
        }
        
        override func deploy_frame(with rect: CGRect) {
            super.deploy_frame(with: rect)
            background.frame = CGRect(
                x: 2,
                y: rect.height - (is_showing ? 102 : -100),
                width: rect.width - 4,
                height: 100
            )
            progress.deploy_frame(with: CGRect(
                x: background.frame.minX + 12,
                y: background.frame.minY + 12,
                width: background.frame.width - 24,
                height: 30
            ))
            labels.current.frame = CGRect(
                x: progress.frame.minX + 6,
                y: progress.frame.maxY - 8,
                width: 42,
                height: 20
            )
            labels.total.frame = CGRect(
                x: progress.frame.maxX - 48,
                y: labels.current.frame.minY,
                width: 42,
                height: 20
            )
            buttons.play.frame = CGRect(
                x: progress.center.x - 20,
                y: background.frame.maxY - 50,
                width: 40,
                height: 40
            )
            buttons.backward.frame = CGRect(
                x: buttons.play.frame.minX - 50,
                y: buttons.play.frame.minY,
                width: buttons.play.frame.width,
                height: buttons.play.frame.height
            )
            buttons.forward.frame = CGRect(
                x: buttons.play.frame.maxX + 10,
                y: buttons.play.frame.minY,
                width: buttons.play.frame.width,
                height: buttons.play.frame.height
            )
            
            
            background_top_right.frame = CGRect(
                x: rect.maxX - 62,
                y: is_showing ? 2 : -120,
                width: 60, height: 60
            )
            buttons.screenshot.frame = CGRect(
                x: background_top_right.frame.minX + 10,
                y: background_top_right.frame.minY + 10,
                width: 40, height: 40
            )
            
            background_top_left.frame = CGRect(
                x: 2,
                y: is_showing ? 2 : -120,
                width: 60, height: 60
            )
            buttons.back.frame = CGRect(
                x: background_top_left.frame.minX + 10,
                y: background_top_left.frame.minY + 10,
                width: 40, height: 40
            )
            
            touch.deploy_frame(with: CGRect(
                x: 0,
                y: 100,
                width: bounds.width,
                height: bounds.height - 200
            ))
        }
        
        // MARK: - Background
        
        /** Bar Background */
        private var background: UIView = UIView()
        private var background_top_right: UIView = UIView()
        private var background_top_left: UIView = UIView()
        
        override func update_background_color() {
            background.backgroundColor = background_color
            background_top_right.backgroundColor = background_color
            background_top_left.backgroundColor = background_color
        }
        
        override func update_background_alpha() {
            background.alpha = background_alpha
            background_top_right.alpha = background_alpha
            background_top_left.alpha = background_alpha
        }
        
        // MARK: - Touch
        
        override func player_console_touch_action() {
            if is_showing {
                console?.timer.hide_bar(in: 0)
            } else {
                animation(show: true)
                if buttons.play.isSelected {
                    console?.timer.hide_bar(in: 5)
                }
            }
        }
        
    }
}
