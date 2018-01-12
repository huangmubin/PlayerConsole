//
//  Console_Bar.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension PlayerConsole {
    
    class Bar: Views, PlayerConsole_Touch_Delegate {
        
        weak var console: PlayerConsole?
        
        var labels: PlayerConsole.Labels = PlayerConsole.Labels()
        var buttons: PlayerConsole.Buttons = PlayerConsole.Buttons()
        var progress: PlayerConsole.Progress = PlayerConsole.Progress()
        var touch: PlayerConsole.Touch = PlayerConsole.Touch()
        
        // MARK: - Deploy
        
        override func deploy_init(to console: PlayerConsole) {
            super.deploy_init(to: console)
            self.console = console
            
            addSubview(labels.name)
            addSubview(labels.current)
            addSubview(labels.total)
            addSubview(buttons.play)
            addSubview(buttons.full)
            addSubview(buttons.screenshot)
            addSubview(buttons.forward)
            addSubview(buttons.backward)
            addSubview(buttons.back)
            
            buttons.delegate_play = console
            buttons.delegate_full = console
            buttons.delegate_screenshot = console
            buttons.delegate_control = console
            buttons.delegate_other = console
            buttons.delegate_back = console
            
            progress.deploy_init(to: console)
            addSubview(progress)
            progress.delegate = console
            
            touch.deploy_init(to: console)
            addSubview(touch)
            touch.delegate = self
        }
        
        override func deploy_frame(with rect: CGRect) {
            super.deploy_frame(with: rect)
            buttons.play.isHidden       = !has_play_button
            buttons.full.isHidden       = !has_full_button
            buttons.screenshot.isHidden = !has_screenshot_button
            buttons.forward.isHidden    = !has_forward_button
            buttons.backward.isHidden   = !has_backward_button
            buttons.back.isHidden       = !has_back_button
        }
        
        // MARK: Background
        
        var background_alpha: CGFloat = 1 {
            didSet { update_background_alpha() }
        }
        func update_background_alpha() { }
        
        var background_color: UIColor = UIColor.darkGray {
            didSet { update_background_color() }
        }
        func update_background_color() { }
        
        // MARK: Buttons
        
        var has_play_button: Bool = true {
            didSet { deploy_frame(with: bounds) }
        }
        
        var has_full_button: Bool = true {
            didSet { deploy_frame(with: bounds) }
        }
        
        var has_screenshot_button: Bool = false {
            didSet { deploy_frame(with: bounds) }
        }
        
        var has_forward_button: Bool = false {
            didSet { deploy_frame(with: bounds) }
        }
        
        var has_backward_button: Bool = false {
            didSet { deploy_frame(with: bounds) }
        }
        
        var has_back_button: Bool = false {
            didSet { deploy_frame(with: bounds) }
        }
        
        // MARK: - Touch
        
        
        
        func player_console_touch_action() { }
        
        // MARK: - Animation
        
        /** 是否会自动隐藏 */
        var auto_hide: Bool = true
        
        /** 当前是否在显示 */
        var is_showing: Bool = false
        
        /** 隐藏，或显示动画 */
        func animation(show: Bool) {
            if is_showing != show {
                is_showing = show
                UIView.animate(withDuration: 0.25, animations: {
                    self.deploy_frame(with: self.superview?.bounds ?? self.bounds)
                    self.animation_call()
                })
            }
        }
        
        func animation_call() { }
    }
    
}
