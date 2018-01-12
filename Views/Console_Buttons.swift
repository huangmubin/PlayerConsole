//
//  Console_Buttons.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

protocol PlayerConsole_Buttons_Play_Delegate: NSObjectProtocol {
    func player_console_buttons(play: Bool)
}
protocol PlayerConsole_Buttons_Full_Delegate: NSObjectProtocol {
    func player_console_buttons(full: Bool)
}
protocol PlayerConsole_Buttons_Screenshot_Delegate: NSObjectProtocol {
    func player_console_buttons_screenshot()
}
protocol PlayerConsole_Buttons_Control_Delegate: NSObjectProtocol {
    func player_console_buttons_forward()
    func player_console_buttons_backward()
}
protocol PlayerConsole_Buttons_Back_Delegate: NSObjectProtocol {
    func player_console_buttons_back()
}
protocol PlayerConsole_Buttons_Other_Delegate: NSObjectProtocol {
    func player_console_buttons_other(key: String, button: UIButton)
}


extension PlayerConsole {
    class Buttons: NSObject {
        override init() {
            super.init()
            play.setImage(PlayerConsole.Resource.play, for: .normal)
            play.setImage(PlayerConsole.Resource.stop, for: .selected)
            play.addTarget(self, action: #selector(play_action), for: .touchUpInside)
            
            full.setImage(PlayerConsole.Resource.full, for: .normal)
            full.setImage(PlayerConsole.Resource.unfull, for: .selected)
            full.addTarget(self, action: #selector(full_action), for: .touchUpInside)
            
            screenshot.addTarget(self, action: #selector(screenshot_action), for: .touchUpInside)
            
            forward.addTarget(self, action: #selector(forward_action), for: .touchUpInside)
            backward.addTarget(self, action: #selector(backward_action), for: .touchUpInside)
            
            back.addTarget(self, action: #selector(back_action), for: .touchUpInside)
            
            if let path = Bundle.main.path(forResource: "Console", ofType: "bundle") {
                if let bundle = Bundle(path: path) {
                    if let path = bundle.path(forResource: "console_play", ofType: "png") {
                        if let image = UIImage(contentsOfFile: path) {
                            play.setImage(image, for: .normal)
                        }
                    }
                    if let path = bundle.path(forResource: "console_stop", ofType: "png") {
                        if let image = UIImage(contentsOfFile: path) {
                            play.setImage(image, for: .selected)
                        }
                    }
                    if let path = bundle.path(forResource: "console_full", ofType: "png") {
                        if let image = UIImage(contentsOfFile: path) {
                            full.setImage(image, for: .normal)
                        }
                    }
                    if let path = bundle.path(forResource: "console_unfull", ofType: "png") {
                        if let image = UIImage(contentsOfFile: path) {
                            full.setImage(image, for: .selected)
                        }
                    }
                    if let path = bundle.path(forResource: "console_screenshot", ofType: "png") {
                        if let image = UIImage(contentsOfFile: path) {
                            screenshot.setImage(image, for: .normal)
                        }
                    }
                    if let path = bundle.path(forResource: "console_forward", ofType: "png") {
                        if let image = UIImage(contentsOfFile: path) {
                            forward.setImage(image, for: .normal)
                        }
                    }
                    if let path = bundle.path(forResource: "console_backward", ofType: "png") {
                        if let image = UIImage(contentsOfFile: path) {
                            backward.setImage(image, for: .normal)
                        }
                    }
                    if let path = bundle.path(forResource: "console_back", ofType: "png") {
                        if let image = UIImage(contentsOfFile: path) {
                            back.setImage(image, for: .normal)
                        }
                    }
                }
            }
        }
        
        weak var delegate_play: PlayerConsole_Buttons_Play_Delegate?
        weak var delegate_full: PlayerConsole_Buttons_Full_Delegate?
        weak var delegate_screenshot: PlayerConsole_Buttons_Screenshot_Delegate?
        weak var delegate_control: PlayerConsole_Buttons_Control_Delegate?
        weak var delegate_back: PlayerConsole_Buttons_Back_Delegate?
        weak var delegate_other: PlayerConsole_Buttons_Other_Delegate?
        
        // MARK: - Play
        
        var play: UIButton = UIButton()
        @objc func play_action() {
            delegate_play?.player_console_buttons(play: !play.isSelected)
        }
        
        // MARK: - Full
        
        var full: UIButton = UIButton()
        @objc func full_action() {
            delegate_full?.player_console_buttons(full: !full.isSelected)
        }
        
        // MARK: - Screenshot
        
        var screenshot: UIButton = UIButton()
        @objc func screenshot_action() {
            delegate_screenshot?.player_console_buttons_screenshot()
        }
        
        // MARK: - Forward Backward
        
        var forward: UIButton = UIButton()
        @objc func forward_action() {
            delegate_control?.player_console_buttons_forward()
        }
        var backward: UIButton = UIButton()
        @objc func backward_action() {
            delegate_control?.player_console_buttons_backward()
        }
        
        // MARK: - Back
        
        var back: UIButton = UIButton()
        @objc func back_action() {
            delegate_back?.player_console_buttons_back()
        }
        
        // MARK: - Other
        
        var other_buttons: [String: UIButton] = [:]
        func add(key: String, button: UIButton) -> Bool {
            if other_buttons[key] == nil {
                other_buttons[key] = button
                button.addTarget(self, action: #selector(other_actions(_:)), for: .touchUpInside)
                return true
            } else {
                return false
            }
        }
        @objc func other_actions(_ sender: UIButton) {
            for (key, button) in other_buttons {
                if button === sender {
                    delegate_other?.player_console_buttons_other(key: key, button: button)
                }
            }
        }
    }
}
