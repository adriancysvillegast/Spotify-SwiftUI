//
//  PlaySongViewModel.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 1/12/23.
//

import Foundation
import SwiftUI

class PlaySongViewModel : ObservableObject {
    
    // MARK: - Properties
    @Published var songDetail: TrackModelCell?
    
    // MARK: - Methods
    
    func getSong(trackId: String) {
        APIManager.shared.getSongDetails(id: trackId) { result in
            switch result {
            case .success(let success):
                let artist = success.artists.compactMap { $0.name }
                let song = TrackModelCell(image: URL(string: success.album?.images.first?.url ?? "-"),
                                          artists: artist.joined(separator: ", "),
                                          explicit: success.explicit,
                                          id: success.id,
                                          name: success.name,
                                          previewUrl: URL(string: success.previewUrl ?? "-"))
                DispatchQueue.main.async {
                    self.songDetail = song
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func playSound(track: TrackModelCell) {
        PlaybackManager.shared.startPlayback(track: track)
    }
    
    func tappedPlayPause() {
        PlaybackManager.shared.tappedPlayPause()
    }
}
