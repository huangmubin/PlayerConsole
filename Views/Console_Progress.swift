//
//  Console_Progress.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

enum PlayerConsoleProgressType {
    case bar
    case point
}

protocol PlayerConsole_Progress_Delegate: NSObjectProtocol {
    func player_console_progress_change(value: CGFloat)
    func player_console_progress_touch_end(value: CGFloat)
}

extension PlayerConsole {
    class Progress: Views {
        weak var delegate: PlayerConsole_Progress_Delegate?
        
        var type: PlayerConsoleProgressType = PlayerConsoleProgressType.bar {
            didSet {
                deploy_frame(with: frame)
                switch type {
                case .bar:
                    layer_slider.shadowOpacity = 1
                    layer_slider.cornerRadius = 3
                case .point:
                    layer_slider.shadowOpacity = 0
                    layer_slider.cornerRadius = 4
                }
            }
        }
        
        func update_layer_slider(with: CGRect) {
            switch type {
            case .bar:
                layer_slider.frame = CGRect(
                    x: 8 + (with.width - 16) * value - 2,
                    y: with.height * 0.2,
                    width: 4,
                    height: with.height * 0.6
                )
            case .point:
                layer_slider.frame = CGRect(
                    x: 8 + (with.width - 16) * value - 4,
                    y: with.height / 2 - 4,
                    width: 8,
                    height: 8
                )
            }
        }
        
        // MARK: - PlayerConsole_Protocol
        
        override func deploy_init(to console: PlayerConsole) {
            layer.addSublayer(layer_background)
            layer.addSublayer(layer_download)
            layer.addSublayer(layer_player)
            layer.addSublayer(layer_slider)
            
            layer_background.strokeColor = UIColor.black.cgColor
            layer_background.lineWidth = 4
            layer_background.lineCap = kCALineCapRound
            layer_download.strokeColor = UIColor.darkGray.cgColor
            layer_download.lineWidth = 4
            layer_download.lineCap = kCALineCapRound
            layer_player.strokeColor = UIColor.lightGray.cgColor
            layer_player.lineWidth = 4
            layer_player.lineCap = kCALineCapRound
            layer_slider.backgroundColor = UIColor.white.cgColor
            switch type {
            case .bar:
                layer_slider.shadowOpacity = 1
                layer_slider.cornerRadius = 3
            case .point:
                layer_slider.shadowOpacity = 0
                layer_slider.cornerRadius = 4
            }
        }
        
        override func deploy_frame(with: CGRect) {
            super.deploy_frame(with: with)
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 8, y: with.height / 2))
            path.addLine(to: CGPoint(x: with.width - 8, y: with.height / 2))
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layer_background.path = path.cgPath
            layer_download.path = path.cgPath
            layer_player.path = path.cgPath
            
            layer_download.strokeEnd = download
            layer_player.strokeEnd = value
            update_layer_slider(with: with)
            CATransaction.commit()
        }
        
        func deploy_frame(with: CGRect, animate: Bool) {
            if animate {
                frame = with
                
                let path = UIBezierPath()
                path.move(to: CGPoint(x: 8, y: with.height / 2))
                path.addLine(to: CGPoint(x: with.width - 8, y: with.height / 2))
                
                layer_background.path = path.cgPath
                layer_download.path = path.cgPath
                layer_player.path = path.cgPath
                
                layer_download.strokeEnd = download
                layer_player.strokeEnd = value
                update_layer_slider(with: with)
            } else {
                deploy_frame(with: with)
            }
        }
        
        // MARK: - PlayerConsole_Progress_Protocol
        
        var layer_background: CAShapeLayer = CAShapeLayer()
        var layer_download: CAShapeLayer = CAShapeLayer()
        var layer_player: CAShapeLayer = CAShapeLayer()
        var layer_slider: CALayer = CALayer()
        
        var value: CGFloat = 0
        var download: CGFloat = 0
        
        func update(value: CGFloat, safe: Bool = true, animate: Bool) {
            if safe && !can_changed_value {
                return
            }
            if value <= 0 {
                if self.value != 0 {
                    self.value = 0
                    deploy_frame(with: frame, animate: animate)
                }
            } else if value >= 1 {
                if self.value != 1 {
                    self.value = 1
                    deploy_frame(with: frame, animate: animate)
                }
            } else if value != self.value {
                self.value = value
                deploy_frame(with: frame, animate: animate)
            }
        }
        
        func update(download: CGFloat) {
            if download <= 0 {
                if self.download != 0 {
                    self.download = 0
                    deploy_frame(with: frame, animate: true)
                }
            } else if download >= 1 {
                if self.download != 1 {
                    self.download = 1
                    deploy_frame(with: frame, animate: true)
                }
            } else if download != self.download {
                self.download = download
                deploy_frame(with: frame, animate: true)
            }
        }
        
        // MARK: - Touch
        
        var can_changed_value: Bool = true
        var touching: Bool = false {
            didSet {
                if touching {
                    can_changed_value = false
                }
            }
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            touching = true
            touch_move(touches)
            delegate?.player_console_progress_change(value: value)
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            touch_move(touches)
            delegate?.player_console_progress_change(value: value)
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            touch_move(touches)
            touching = false
            delegate?.player_console_progress_touch_end(value: value)
        }
        
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            touch_move(touches)
            touching = false
            delegate?.player_console_progress_touch_end(value: value)
        }
        
        func touch_move(_ touches: Set<UITouch>) {
            if let touch = touches.first?.location(in: self) {
                update(value: (touch.x - 8) / (frame.width - 16), safe: false, animate: false)
            }
        }
        
    }
}
