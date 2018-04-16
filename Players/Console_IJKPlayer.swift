//
//  Console_IJKPlayer.swift
//  PlayerConsole
//
//  Created by Myron on 2018/1/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation
import IJKMediaFramework

/*
 #         libc++.tbd
 #         AudioToolbox.framework
 #         AVFoundation.framework
 #         CoreGraphics.framework
 #         CoreMedia.framework
 #         CoreVideo.framework
 #         libbz2.tbd
 #         libz.tbd
 #         MediaPlayer.framework
 #         MobileCoreServices.framework
 #         OpenGLES.framework
 #         QuartzCore.framework
 #         UIKit.framework
 #         VideoToolbox.framework
 #
 */

extension PlayerConsole {
    
    class Player_IJK: Player {
        // MARK: - Value
        
        var ijk_player: IJKFFMoviePlayerController?
        
        // MARK: - Load
        
        override func load(url: URL) {
            IJKFFMoviePlayerController.setLogReport(false)
            IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_INFO)
            IJKFFMoviePlayerController.checkIfFFmpegVersionMatch(true)
            
            let options = IJKFFOptions.byDefault()
            self.ijk_player = IJKFFMoviePlayerController(contentURL: url, with: options)
            self.ijk_player?.view.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleHeight.rawValue | UIViewAutoresizing.flexibleWidth.rawValue)
            self.ijk_player?.view.frame = bounds
            self.set(model: superview?.contentMode ?? .scaleAspectFit)
            self.ijk_player?.shouldAutoplay = true
            self.autoresizesSubviews = true
            if let view = self.ijk_player?.view {
                view.backgroundColor = UIColor.clear
                addSubview(view)
            }
        }
        
        override func deploy_frame(with rect: CGRect) {
            super.deploy_frame(with: rect)
            UIView.animate(withDuration: 0.1) {
                self.ijk_player?.view.frame = self.bounds
            }
        }
        
        // MARK: - Play Control
        
        override func play() {
            switch state {
            case .loading:
                ijk_player?.prepareToPlay()
                state = .playing
            case .pause:
                if time_value() == 1 {
                    move_to(value: 0)
                    ijk_player?.prepareToPlay()
                } else {
                    ijk_player?.play()
                }
                state = .playing
            case .stop, .error(_):
                load(url: url)
                ijk_player?.prepareToPlay()
                state = .playing
            case .playing: break
            }
        }
        
        override func pause() {
            switch state {
            case .pause:
                ijk_player?.play()
                state = .playing
            case .playing:
                ijk_player?.pause()
                state = .pause
            default: break
            }
        }
        
        override func stop() {
            ijk_player?.pause()
            move_to(value: 0)
            state = .stop
        }
        
        override func clear() {
            ijk_player?.stop()
            ijk_player?.shutdown()
            ijk_player = nil
            setNeedsDisplay()
            state = .error(PlayerConsole_Player_State.no_load)
        }
        
        // MARK: - Screenshort
        
        override func screenshort(time: Int? = nil) -> UIImage? {
            return ijk_player?.thumbnailImageAtCurrentTime()
        }
        
        // MARK: - Time
        
        override func time_total() -> TimeInterval {
            return ijk_player?.duration ?? 0
        }
        override func time_current() -> TimeInterval {
            return ijk_player?.currentPlaybackTime ?? 0
        }
        override func time_value() -> CGFloat {
            if let duraion = ijk_player?.duration, let current = ijk_player?.currentPlaybackTime {
                if duraion > 0 {
                    return CGFloat(current / duraion)
                }
            }
            return 0
        }
        
        // MRAK: - Move
        
        override func move_to(value: CGFloat) {
            ijk_player?.currentPlaybackTime = TimeInterval(value) * time_total()
        }
        
        // MARK: - Model
        
        override func set(model: UIViewContentMode) {
            switch model {
            case .scaleToFill:
                ijk_player?.scalingMode = IJKMPMovieScalingMode.fill
            case .scaleAspectFit:
                ijk_player?.scalingMode = IJKMPMovieScalingMode.aspectFit
            case .scaleAspectFill:
                ijk_player?.scalingMode = IJKMPMovieScalingMode.aspectFill
            default:
                ijk_player?.scalingMode = IJKMPMovieScalingMode.fill
            }
        }
    }
    
}
