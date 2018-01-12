//
//  Console_Labels.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension PlayerConsole {
    class Labels {
        
        init() {
            current.textColor = UIColor.white
            total.textColor = UIColor.white
            
            current.text = "00:00"
            total.text = "00:00"
            
            current.textAlignment = .center
            total.textAlignment = .center
            
            name.textColor = UIColor.white
        }
        
        func update(color: UIColor) {
            total.textColor = color
            current.textColor = color
        }
        
        func update(font: UIFont) {
            total.font = font
            current.font = font
        }
        
        // MARK: - Time
        
        var current: UILabel = UILabel()
        var total: UILabel = UILabel()
        
        func update(current text: String) {
            current.text = text
        }
        
        func update(total text: String) {
            total.text = text
        }
        
        func update_time(current: String, total: String) {
            self.current.text = current
            self.total.text = total
        }
        
        // MARK: - Name Label
        
        var name: UILabel = UILabel()
        
        func update(name text: String, prefix: String = "name: ") {
            self.name.text = prefix + text
        }
        
        // MARK: - Info Labels
        
        var info_labels: [String: UILabel] = [:]
        func label(_ name: String) -> UILabel? {
            return info_labels[name]
        }
    }
}
