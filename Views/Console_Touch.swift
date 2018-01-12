//
//  Console_Center.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/11.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

protocol PlayerConsole_Touch_Delegate: NSObjectProtocol {
    func player_console_touch_action()
}

extension PlayerConsole {
    
    class Touch: Views {
        
        weak var delegate: PlayerConsole_Touch_Delegate?
        
        var image_view: UIImageView = UIImageView()
        var image_size: CGSize = CGSize(width: 40, height: 40)
        
        func image(show: Bool) {
            UIView.animate(withDuration: 0.25, animations: {
                self.image_view.alpha = show ? 1 : 0
            })
        }
        
        var button: UIButton = UIButton()
        @objc func button_action() {
            delegate?.player_console_touch_action()
        }
        
        // MARK: - Deploy
        
        override func deploy_init(to console: PlayerConsole) {
            super.deploy_init(to: console)
            addSubview(button)
            addSubview(image_view)
            
            image_view.image = PlayerConsole.Resource.image("play")
            button.addTarget(self, action: #selector(button_action), for: .touchUpInside)
        }
        
        override func deploy_frame(with rect: CGRect) {
            super.deploy_frame(with: rect)
            button.frame = bounds
            image_view.frame = CGRect(
                x: (bounds.width - image_size.width) / 2,
                y: (bounds.height - image_size.height) / 2,
                width: image_size.width,
                height: image_size.height
            )
        }
        
    }
    
}
