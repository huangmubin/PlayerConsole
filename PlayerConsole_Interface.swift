//
//  PlayerConsole_Interface.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension PlayerConsole {
    
    // MARK: - Load Video
    
    func load(file: String) {
        player.load(local_video: file)
    }
    
    func load(network: String) {
        player.load(network_video: network)
    }
    
    // MARK: - Controls
    
    func play() {
        player_console_buttons(play: true)
    }
    
    // MARK: - Images
    
    @IBInspectable var image_play: UIImage? {
        set { bar.buttons.play.setImage(newValue, for: .normal) }
        get { return bar.buttons.play.image(for: .normal) }
    }
    
    @IBInspectable var image_stop: UIImage? {
        set { bar.buttons.play.setImage(newValue, for: .selected) }
        get { return bar.buttons.play.image(for: .selected) }
    }
    
    @IBInspectable var image_full: UIImage? {
        set { bar.buttons.full.setImage(newValue, for: .normal) }
        get { return bar.buttons.full.image(for: .normal) }
    }
    
    @IBInspectable var image_unfull: UIImage? {
        set { bar.buttons.full.setImage(newValue, for: .selected) }
        get { return bar.buttons.full.image(for: .selected) }
    }
    
    @IBInspectable var image_screenshot: UIImage? {
        set { bar.buttons.screenshot.setImage(newValue, for: .normal) }
        get { return bar.buttons.screenshot.image(for: .normal) }
    }
    
    @IBInspectable var image_forward: UIImage? {
        set { bar.buttons.forward.setImage(newValue, for: .normal) }
        get { return bar.buttons.forward.image(for: .normal) }
    }
    
    @IBInspectable var image_backward: UIImage? {
        set { bar.buttons.backward.setImage(newValue, for: .normal) }
        get { return bar.buttons.backward.image(for: .normal) }
    }
    
    
    
}
