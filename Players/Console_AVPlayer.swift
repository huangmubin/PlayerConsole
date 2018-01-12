//
//  Console_AVPlayer.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit
import AVFoundation

extension PlayerConsole {
    
    class Player_AV: PlayerConsole.Player {
        
        // MARK: - Values
        
        var av_item: AVPlayerItem?
        var av_player: AVPlayer?
        var av_layer: AVPlayerLayer?
        
        // MARK: - Override
        
        override func deploy_frame(with rect: CGRect) {
            super.deploy_frame(with: rect)
            av_layer?.frame = bounds
        }
        
        // MARK: - Load
        
        override func load(url: URL) {
            super.load(url: url)
            av_item   = AVPlayerItem(url: url)
            av_player = AVPlayer(playerItem: av_item)
            av_layer  = AVPlayerLayer(player: av_player)
            av_layer?.frame = bounds
            self.layer.addSublayer(av_layer!)
            state = .loading
            set(model: superview?.contentMode ?? .scaleAspectFit)
        }
        
        // MARK: - Controls
        
        override func play() {
            switch state {
            case .loading, .pause:
                if time_value() == 1 { move_to(value: 0) }
                av_player?.play()
                state = .playing
            case .stop, .error(_):
                load(url: url)
                av_player?.play()
                state = .playing
            case .playing: break
            }
        }
        
        override func pause() {
            switch state {
            case .pause:
                av_player?.play()
                state = .playing
            case .playing:
                av_player?.pause()
                state = .pause
            default: break
            }
        }
        
        override func stop() {
            av_player?.pause()
            move_to(value: 0)
            state = .stop
        }
        
        override func clear() {
            av_player?.pause()
            move_to(value: 0)
            av_item = nil
            av_layer?.removeFromSuperlayer()
            setNeedsDisplay()
            state = .error(PlayerConsole_Player_State.no_load)
        }
        
        // MARK: - Screenshort
        
        override func screenshort(time: Int? = nil) -> UIImage? {
            if let asset = av_item?.asset {
                do {
                    let generator = AVAssetImageGenerator(asset: asset)
                    generator.appliesPreferredTrackTransform = true
                    var cm_timer = CMTime()
                    var image_time: CMTime
                    if let cut_time = time {
                        image_time = CMTime(value: CMTimeValue(cut_time), timescale: 10)
                    } else {
                        image_time = av_item!.currentTime()
                    }
                    let imageref = try generator.copyCGImage(at: image_time, actualTime: &cm_timer)
                    return UIImage(cgImage: imageref)
                } catch { }
            }
            return nil
        }
        
        // MARK: - Time
        
        override func time_total() -> TimeInterval {
            if let time = av_item?.duration.seconds {
                if time > 0 {
                    return time
                }
            }
            return 0
        }
        
        override func time_current() -> TimeInterval {
            if let time = av_item?.currentTime().seconds {
                if time > 0 {
                    return time
                }
            }
            return 0
        }
        
        override func time_value() -> CGFloat {
            if let current = av_item?.currentTime().seconds, let duration = av_item?.duration.seconds {
                if current > 0 && duration > 0 {
                    return CGFloat(current) / CGFloat(duration)
                }
            }
            return 0
        }
        
        // MRAK: - Move
        
        override func move_to(value: CGFloat) {
            let time = time_total() * Double(value)
            if #available(iOS 11.0, *) {
                av_item?.seek(to: CMTime(value: CMTimeValue(time), timescale: 1), completionHandler: { (value) in })
            } else {
                av_item?.seek(to: CMTime(value: CMTimeValue(time), timescale: 1))
            }
        }
        
        // MARK: - Model
        
        override func set(model: UIViewContentMode) {
            self.contentMode = model
            switch model {
            case .scaleToFill:
                av_layer?.videoGravity = .resize
            case .scaleAspectFit:
                av_layer?.videoGravity = .resizeAspect
            case .scaleAspectFill:
                av_layer?.videoGravity = .resizeAspectFill
            default:
                av_layer?.videoGravity = .resizeAspect
            }
        }
    }
    
}
