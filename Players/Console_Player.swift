//
//  Console_Player.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

enum PlayerConsole_Player_State {
    case loading
    case playing
    case pause
    case stop
    case error(String)
    
    static let no_load: String = "No load anything."
}

// MARK: - Player

extension PlayerConsole {
    
    class Player: Views {
        
        // MARK: - Value
        
        var url: URL = URL(fileURLWithPath: NSHomeDirectory())
        var state: PlayerConsole_Player_State = .error(PlayerConsole_Player_State.no_load)
        
        // MARK: - Load
        
        func load(local_video: String) {
            url = URL(fileURLWithPath: local_video)
            load(url: url)
        }
        func load(network_video: String) {
            if let url = URL(string: network_video) {
                self.url = url
                load(url: url)
            }
        }
        func load(url: URL) { }
        
        // MARK: - Play Control
        
        func play() { }
        func pause() { }
        func stop() { }
        func clear() { }
        
        // MARK: - Screenshort
        
        func screenshort(time: Int? = nil) -> UIImage? { return nil }
        
        // MARK: - Time
        
        func time_total() -> TimeInterval { return 0 }
        func time_current() -> TimeInterval { return 0 }
        func time_value() -> CGFloat { return 0 }
        
        // MRAK: - Move
        
        func move_to(value: CGFloat) { }
        
        // MARK: - Model
        
        func set(model: UIViewContentMode) { }
    }
    
}
