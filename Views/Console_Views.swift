//
//  Console_Views.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension PlayerConsole {
    class Views: UIView {
        func deploy_init(to console: PlayerConsole) {
            self.frame = console.bounds
            console.addSubview(self)
        }
        func deploy_frame(with rect: CGRect) {
            self.frame = rect
        }
    }
}
