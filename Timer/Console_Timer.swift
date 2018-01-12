//
//  Console_Timer.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

protocol PlayerConsole_Timer_Delegate: NSObjectProtocol {
    func delegate_timer_loop()
    func delegate_timer_hide_bar()
    func delegate_timer_seek()
}

extension PlayerConsole {
    /** The time in the player console, must be call the run() */
    class Timer {
        weak var delegate: PlayerConsole_Timer_Delegate?
        var timer: DispatchSourceTimer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags.init(rawValue: 1), queue: DispatchQueue.main)
        
        func run(time: Int = 250) {
            timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: DispatchTimeInterval.milliseconds(time))
            timer.setEventHandler(handler: { [weak self] in
                self?.delegate?.delegate_timer_loop()
                if let bar = self?.hide_bar_time {
                    if bar >= 0 {
                        self?.hide_bar_time = bar - 1
                    }
                    if bar == 0 {
                        self?.delegate?.delegate_timer_hide_bar()
                    }
                }
                if let seek = self?.seek_time {
                    if seek >= 0 {
                        self?.seek_time = seek - 1
                    }
                    if seek == 0 {
                        self?.delegate?.delegate_timer_seek()
                    }
                }
            })
            timer.resume()
        }
        
        // MARK: Bar
        
        private var hide_bar_time: Int = -1
        /** 0 ~ ... */
        func hide_bar(`in` time: TimeInterval) {
            if time < 0 {
                hide_bar_time = -1
            } else {
                hide_bar_time = Int(time * 4)
            }
        }
        
        // MARK: Seek
        
        private var seek_time: Int = -1
        func seek(to time: TimeInterval) {
            if time < 0 {
                seek_time = -1
            } else {
                seek_time = Int(time * 4)
            }
        }
        
    }
}
