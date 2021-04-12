//
//  ViewController.swift
//  AVPlayerFade
//
//  Created by Evandro Harrison Hoffmann on 21/05/2020.
//  Copyright © 2020 It's Day Off. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "music1", withExtension: "mp3")!
        self.playAudioWithFadeInFadeOut(url: url)
    }
    
    private var player: AVPlayer?

    func playAudioWithFadeInFadeOut(url: URL) {
        let asset = AVAsset(url: url)
        self.player = AVPlayer(url: url)
        let duration = asset.duration
        let durationInSeconds = CMTimeGetSeconds(duration)

        let item = AVPlayerItem(asset: asset)
        let params = AVMutableAudioMixInputParameters(track: asset.tracks.first! as AVAssetTrack)

        let firstSecond = CMTimeRangeMake(start: CMTimeMakeWithSeconds(0, preferredTimescale: 1000), duration: CMTimeMakeWithSeconds(5, preferredTimescale: 1000))
        let lastSecond = CMTimeRangeMake(start: CMTimeMakeWithSeconds(5.0, preferredTimescale: 1000), duration: CMTimeMakeWithSeconds(5, preferredTimescale: 1000))

        params.setVolumeRamp(fromStartVolume: 0, toEndVolume: 1, timeRange: firstSecond)
        params.setVolumeRamp(fromStartVolume: 1, toEndVolume: 0, timeRange: lastSecond)

        let mix = AVMutableAudioMix()
        mix.inputParameters = [params]
        item.audioMix = mix
        
       // print("D  ", duration.seconds,"  ", player)
        self.player?.addPeriodicTimeObserver(forInterval:  CMTimeMakeWithSeconds(0.01, preferredTimescale: 1000), queue: DispatchQueue.main, using: { [weak self] (CMTime) in

        })
        player?.replaceCurrentItem(with: item)
        player?.play()
    }

}
