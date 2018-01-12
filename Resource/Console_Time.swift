//
//  Console_Time.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension PlayerConsole {
    class Time {
        // MARK: Time
        
        var current: TimeInterval = 0
        var total: TimeInterval = 0
        var progress: CGFloat {
            if total > 0 {
                return CGFloat(round(current) / round(total))
            }
            return 0
        }
        
        // MARK: - Text
        
        func format(_ value: Int) -> String {
            return String(format: "%02d:%02d", value / 60, value % 60)
        }
        var current_text: String {
            return format(Int(round(current)))
        }
        var total_text: String {
            return format(Int(round(total)))
        }
    }
}
