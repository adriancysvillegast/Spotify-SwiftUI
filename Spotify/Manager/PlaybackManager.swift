//
//  PlaybackManager.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 2/12/23.
//

import Foundation
import AVFoundation
import SwiftUI

final class PlaybackManager: ObservableObject {
    // MARK: - Properties
    static let shared: PlaybackManager = PlaybackManager()
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    
    private var track: TrackModelCell?
    private var tracks = [TrackModelCell]()
    private var index = 0
    
    private var currentTrack: TrackModelCell? {
        if let track = track, tracks.isEmpty {
            return track
        }else if let player = self.playerQueue, !tracks.isEmpty {
            return tracks[index]
        }
        return nil
    }
    
    
    // MARK: - Methods
    
    func startPlayback(track: TrackModelCell) {
            //playSong
            print(track.previewUrl)
            guard let url = track.previewUrl else {
                return
            }
            
            player = AVPlayer(url: url)
            player?.volume = AVAudioSession.sharedInstance().outputVolume
            
            self.track = track
            self.tracks = []
            
            player?.play()
        }

    func startPlayback(
        tracks: [TrackModelCell]
        ) {
            self.tracks = tracks
            self.track = nil
            
            self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
                guard let url = $0.previewUrl else { return nil }
                return AVPlayerItem(url: url)
            }))
            self.playerQueue?.volume = AVAudioSession.sharedInstance().outputVolume
            self.playerQueue?.play()
        }
        
    
    func tappedPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }else if player.timeControlStatus == .paused {
                player.play()
            }
        }else if let playerList = playerQueue {
            if playerList.timeControlStatus == .playing{
                playerList.pause()
            }else if playerList.timeControlStatus == .paused {
                playerList.play()
            }
        }
    }
}
