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
    
    func load(url: URL) {
        player.load(url: url)
    }
    
    // MARK: - Controls
    
    func play() {
        player_console_buttons(play: true)
    }
    
    func stop() {
        player_console_buttons(play: false)
    }
    
    func clear() {
        player_console_buttons(play: false)
        player.clear()
        progress(to: 0)
    }
    
    /** Change the player progress in 0 ~ 1 */
    func progress(to value: CGFloat) {
        if value >= 0 && value <= 1 {
            player_console_progress_touch_end(value: value)
        } else if value < 0 {
            player_console_progress_touch_end(value: 0)
        } else {
            player_console_progress_touch_end(value: 1)
        }
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
    
    // MARK: - Image
    
    /** */
    func screenshot(at time: Double? = nil) -> UIImage? {
        if time == nil {
            return player.screenshort(time: nil)
        } else {
            return player.screenshort(time: Int(time! * 10))
        }
    }
    
}
