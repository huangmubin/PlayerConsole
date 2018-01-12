//
//  PlayerConsole.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

// MARK: - PlayerConsole Delegate

protocol PlayerConsole_State_Delegate: NSObjectProtocol {
    func player_console_state(play: Bool)
    func player_console_state(full: Bool) -> Bool
}

protocol PlayerConsole_Time_Delegate: NSObjectProtocol {
    func player_console_time(value: CGFloat, current: TimeInterval, total: TimeInterval)
}

// MARK: - Player Console

class PlayerConsole: UIView,
    PlayerConsole_Timer_Delegate,
    PlayerConsole_Progress_Delegate,
    PlayerConsole_Buttons_Play_Delegate,
    PlayerConsole_Buttons_Full_Delegate,
    PlayerConsole_Buttons_Screenshot_Delegate,
    PlayerConsole_Buttons_Control_Delegate,
    PlayerConsole_Buttons_Back_Delegate,
    PlayerConsole_Buttons_Other_Delegate
{

    weak var delegate_state: PlayerConsole_State_Delegate?
    weak var delegate_time: PlayerConsole_Time_Delegate?
    
    // MARK: - Value
    
    var screenshot: UIImage?
    
    // MARK: - Background
    
    var background: PlayerConsole.Background = PlayerConsole.Background()
    
    @IBInspectable
    var thumbnail: UIImage? {
        get { return background.thumbnail.image }
        set { background.thumbnail.image = newValue }
    }

    // MARK: - Time
    
    var time: PlayerConsole.Time = PlayerConsole.Time()
    
    // MARK: - Player
    
    var player: PlayerConsole.Player = PlayerConsole.Player_AV() {
        didSet {
            if oldValue !== player {
                oldValue.clear()
                oldValue.removeFromSuperview()
            }
            player.deploy_init(to: self)
            player.deploy_frame(with: bounds)
            bringSubview(toFront: bar)
        }
    }
    
    // MARK: - Bar
    
    @IBInspectable
    var bar_type: String = "Embed" {
        didSet {
            switch bar_type {
            case "Simple":
                if !(bar is PlayerConsole.Bar_Simple) {
                    bar = PlayerConsole.Bar_Simple()
                }
            case "Embed":
                if !(bar is PlayerConsole.Bar_Embed) {
                    bar = PlayerConsole.Bar_Embed()
                }
            case "Fully":
                if !(bar is PlayerConsole.Bar_Fully) {
                    bar = PlayerConsole.Bar_Fully()
                }
            default: break
            }
        }
    }
    
    var bar: PlayerConsole.Bar = PlayerConsole.Bar_Embed() {
        didSet {
            oldValue.removeFromSuperview()
            bar.deploy_init(to: self)
            bar.deploy_frame(with: bounds)
        }
    }
    
    func player_console_progress_change(value: CGFloat) { }
    
    func player_console_progress_touch_end(value: CGFloat) {
        player.move_to(value: value)
        timer.seek(to: 2)
    }
    
    // MARK: - Buttons
    
    func player_console_buttons(play: Bool) {
        if play {
            player.play()
            bar.touch.image(show: false)
            bar.buttons.play.isSelected = true
            bar.animation(show: true)
            if bar.auto_hide {
                timer.hide_bar(in: 5)
            }
            delegate_state?.player_console_state(play: true)
        } else {
            player.pause()
            bar.touch.image(show: true)
            bar.buttons.play.isSelected = false
            bar.animation(show: true)
            timer.hide_bar(in: -1)
            delegate_state?.player_console_state(play: false)
        }
    }
    
    func player_console_buttons(full: Bool) { }
    
    func player_console_buttons_screenshot() {
        screenshot = player.screenshort()
    }
    
    func player_console_buttons_forward() { }
    
    func player_console_buttons_backward() { }
    
    func player_console_buttons_back() { }
    
    func player_console_buttons_other(key: String, button: UIButton) { }
    
    // MARK: - Timer
    
    var timer: PlayerConsole.Timer = PlayerConsole.Timer()
    
    func delegate_timer_loop() {
        time.current = player.time_current()
        time.total = player.time_total()
        
        bar.labels.update(current: time.current_text)
        bar.labels.update(total: time.total_text)
        bar.progress.update(value: time.progress, safe: true , animate: true)
        
        // Play End
        if time.progress == 1 {
            player.pause()
            player.state = .loading
            bar.buttons.play.isSelected = false
            bar.animation(show: true)
        }
    }
    
    func delegate_timer_seek() {
        bar.progress.can_changed_value = true
    }
    
    func delegate_timer_hide_bar() {
        bar.animation(show: false)
        bar.touch.image(show: false)
    }
    
    // MARK: - Deploy
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        deploy_init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deploy_init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deploy_init()
    }
    
    private func deploy_init() {
        background.deploy_init(to: self)
        player.deploy_init(to: self)
        bar.deploy_init(to: self)
        timer.run()
        timer.delegate = self
    }
    
    // MARK: - Frame
    
    override var frame: CGRect {
        didSet { deploy_frame(old: oldValue) }
    }
    
    override var bounds: CGRect {
        didSet { deploy_frame(old: oldValue) }
    }
    
    func deploy_frame(old: CGRect) {
        if bounds.width != old.width
            || bounds.height != old.height {
            background.deploy_frame(with: bounds)
            player.deploy_frame(with: bounds)
            bar.deploy_frame(with: bounds)
        }
    }
    
    // MARK: Content Model
    
    override var contentMode: UIViewContentMode {
        didSet {
            background.thumbnail.contentMode = contentMode
            player.set(model: contentMode)
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            bar.background_color = tintColor
        }
    }
    
}

